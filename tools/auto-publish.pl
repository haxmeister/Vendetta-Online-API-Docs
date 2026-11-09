#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;
use FindBin;
use File::Copy qw(copy);
use File::Path qw(make_path);
use File::Spec;
use File::Temp qw(tempdir);

# Only invoked by the explicitly opted-in tools/assist.pl launcher.
# Publish a single generated report, from an isolated detached worktree.
# Never push the user's pending local commits or modify their worktree/index.
my $repo = File::Spec->rel2abs(File::Spec->catdir($FindBin::Bin, '..'));
my $tmp = tempdir('voapi-publish-XXXXXX', TMPDIR => 1, CLEANUP => 1);
my $worktree = File::Spec->catdir($tmp, 'checkout');
my $marker = File::Spec->catfile($tmp, 'reviewed-through.txt');
my $report = File::Spec->catfile($tmp, 'capture-summary.md');

sub git (@args) {
    system('git', '-C', $repo, @args) == 0
        or die "git @args failed; no new report published\n";
}

sub git_output (@args) {
    open my $fh, '-|', 'git', '-C', $repo, @args
        or die "cannot start git @args: $!\n";
    local $/;
    my $body = <$fh> // '';
    close($fh) or die "git @args failed\n";
    return $body;
}

git('fetch', '--quiet', 'origin', 'main');
my $reviewed = git_output('show',
    'refs/remotes/origin/main:data/reviewed-through.txt');
open my $cutoff, '>:raw', $marker or die "$marker: $!\n";
print {$cutoff} $reviewed;
close $cutoff or die "$marker: $!\n";

# The generator uses the remote review cutoff; a stale local main cannot
# accidentally republish captures already consolidated by ChatGPT.
my $generator = File::Spec->catfile($FindBin::Bin, 'share-observations.pl');
system($^X, $generator, '--output', $report, '--reviewed-file', $marker) == 0
    or die "capture report generation failed\n";
if (!-s $report) {
    say 'No new captures to publish.';
    exit 0;
}

my $attached = 0;
my $error;
eval {
    git('worktree', 'add', '--quiet', '--detach', $worktree,
        'refs/remotes/origin/main');
    $attached = 1;
    my $destination = File::Spec->catfile(
        $worktree, 'docs', 'research', 'capture-summary.md');
    my (undef, $dir) = File::Spec->splitpath($destination);
    make_path($dir) if !-d $dir;
    copy($report, $destination) or die "copy report: $!\n";
    system('git', '-C', $worktree, 'add', '--',
        'docs/research/capture-summary.md') == 0
        or die "cannot stage report\n";

    my $diff = system('git', '-C', $worktree, 'diff', '--cached',
        '--quiet', '--', 'docs/research/capture-summary.md');
    die "git diff error\n" if $diff == -1 || ($diff != 0 && $diff != 256);
    if ($diff == 0) {
        say 'Published report already matches GitHub.';
    } else {
        system('git', '-C', $worktree, 'commit', '--quiet', '-m',
            'Automatically share new VO API observations') == 0
            or die "report commit failed\n";
        system('git', '-C', $worktree, 'push', '--quiet',
            'origin', 'HEAD:refs/heads/main') == 0
            or die "GitHub changed during publication; retry on next pass\n";
        say 'Published new capture report to GitHub.';
    }
    1;
} or $error = $@ || 'unknown publication error';

if ($attached) {
    system('git', '-C', $repo, 'worktree', 'remove', '--force', $worktree) == 0
        or warn "could not clean up temporary worktree $worktree\n";
}
die $error if $error;
