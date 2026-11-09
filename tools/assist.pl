#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;
use FindBin;
use File::Path qw(make_path);
use File::Spec;
use Getopt::Long qw(GetOptions);
use POSIX qw(WNOHANG);

# Run once in a terminal. The child collector handles live sockets.
# This parent handles GitHub sync and opted-in report-only publication.
my $repo = File::Spec->rel2abs(File::Spec->catdir($FindBin::Bin, '..'));
my $interval = 60;
my $flush_seconds = 180;
my $help;
GetOptions(
    'poll-seconds=i'  => \$interval,
    'flush-seconds=i' => \$flush_seconds,
    'help'            => \$help,
) or die "usage: perl tools/assist.pl [--poll-seconds 60] [--flush-seconds 180]\n";
if ($help) {
    say 'usage: perl tools/assist.pl [--poll-seconds 60] [--flush-seconds 180]';
    exit 0;
}
die "poll-seconds must be at least 20\n" if $interval < 20;
die "flush-seconds must be at least 30\n" if $flush_seconds < 30;
my $captures = File::Spec->catdir($repo, 'captures');
make_path($captures, {mode => 0700});
my $guidance = File::Spec->catfile($captures, '.assistant-plan.txt');

sub git_text (@args) {
    open my $fh, '-|', 'git', '-C', $repo, @args or return;
    local $/;
    my $body = <$fh>;
    return close($fh) ? $body : undef;
}
sub refresh_plan () {
    my $old_main = git_text('rev-parse', 'HEAD') // '';
    my $old_plugin = git_text('rev-parse', 'HEAD:plugin/APIProbe/main.lua') // '';
    my $fetch = system('git', '-C', $repo, 'fetch', '--quiet', 'origin', 'main');
    if ($fetch != 0) {
        warn "GitHub fetch failed; keeping existing guidance\n";
        return;
    }

    # Fast-forward only if the local tracked files are clean. Never reset,
    # force, rebase, or overwrite a user's uncommitted changes.
    my $dirty = git_text('status', '--porcelain', '--untracked-files=no');
    if (defined $dirty && $dirty eq '') {
        my $merge = system('git', '-C', $repo, 'merge', '--ff-only',
            'refs/remotes/origin/main');
        warn "Could not fast-forward local repo; continuing with remote plan\n"
            if $merge != 0;
    } else {
        warn "Local tracked edits detected; skipped repository auto-update\n";
    }
    my $new_main = git_text('rev-parse', 'HEAD') // '';
    my $new_plugin = git_text('rev-parse', 'HEAD:plugin/APIProbe/main.lua') // '';

    my $plan = git_text('show', 'refs/remotes/origin/main:control/plan.txt');
    return if !defined $plan;
    $plan =~ s/\r\n/\n/g;
    if ($old_main ne $new_main && $old_plugin ne $new_plugin) {
        $plan .= "\nRELOAD|APIProbe main.lua changed locally; reload the game interface when convenient.\n";
    }
    if (-f $guidance) {
        open my $in, '<:raw', $guidance or die "$guidance: $!\n";
        local $/;
        my $previous = <$in>;
        close $in;
        return if defined($previous) && $previous eq $plan;
    }
    my $tmp = "$guidance.$$";
    open my $out, '>:raw', $tmp or die "$tmp: $!\n";
    print {$out} $plan;
    close $out or die "$tmp: $!\n";
    rename($tmp, $guidance) or die "rename guidance: $!\n";
    say 'Updated in-game guidance from GitHub.';
}

# Initial plan is available before the game connects.
refresh_plan();

my $collector = File::Spec->catfile($FindBin::Bin, 'collect.pl');
my $child = fork();
die "fork collector failed: $!\n" if !defined $child;
if (!$child) {
    exec($^X, $collector, '--guidance-file', $guidance,
        '--flush-seconds', $flush_seconds);
    die "could not exec collector: $!\n";
}

$| = 1;
say "Research bridge running (collector PID $child).";
say "In-game: /apidocs start";
say "Guidance changes sync from control/plan.txt every $interval seconds.";
say "New observations will be published automatically to PUBLIC GitHub.";
say "WARNING: non-chat captures may contain player names or other private values.";
say "Press Ctrl-C to stop this local bridge.";

my $stopping = 0;
$SIG{INT} = sub { $stopping = 1 };
$SIG{TERM} = sub { $stopping = 1 };

my $last_publish = 0;
while (!$stopping) {
    # Do not leave an orphaned bridge if the collector exits.
    my $done = waitpid($child, WNOHANG);
    last if $done == $child;
    sleep($interval);
    last if $stopping;
    eval { refresh_plan(); 1 } or warn "plan check: $@";
    if (time() - $last_publish >= 120) {
        $last_publish = time();
        my $publisher = File::Spec->catfile($FindBin::Bin, 'auto-publish.pl');
        my $ok = system($^X, $publisher);
        warn "auto-publication failed; will retry\n" if $ok != 0;
    }
}
kill 'TERM', $child;
waitpid($child, 0);
say "Research bridge stopped. Local captures remain available.";
