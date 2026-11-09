#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
use Getopt::Long qw(GetOptions);
use File::Spec;
use Digest::SHA qw(sha256_hex);
use Scalar::Util qw(refaddr);
use Linux::Event::Kernel::Timer;
use Linux::Event::IO::Sock::Listener;
use Linux::Event::IO::Sock::Stream;
use Linux::Event::Framer;
use Linux::Event::Loop;
use VOAPI::Collector;

{
    package VOAPI::Collector::Connection;
    use parent 'Linux::Event::IO::Sock::Stream';
    use Linux::Event::Framer 'DecimalLength',
        separator => ':',
        max_frame => 262_144;
}

my $port = 54000;
my $out = File::Spec->catdir($FindBin::Bin, '..', 'captures');
my ($help, $guidance_file, $flush_seconds) = (0, undef, 180);
GetOptions(
    'port=i'          => \$port,
    'out=s'           => \$out,
    'guidance-file=s' => \$guidance_file,
    'flush-seconds=i' => \$flush_seconds,
    'help'            => \$help,
) or die "usage: perl tools/collect.pl [--port 54000] [--out captures] [--guidance-file FILE] [--flush-seconds 180]\n";

if ($help) {
    say 'usage: perl tools/collect.pl [--port 54000] [--out captures] [--guidance-file FILE] [--flush-seconds 180]';
    exit 0;
}
die "port must be between 1 and 65535\n"
    if $port < 1 || $port > 65535;
die "flush-seconds must be at least 30\n" if $flush_seconds < 30;

umask 0077;
my $store = VOAPI::Collector->new(root => $out);
my $loop = Linux::Event::Loop->new;

my %clients;
my ($active_plan, $active_revision) = ('', '');
my $read_plan = sub {
    return ('', '') if !defined $guidance_file || !-f $guidance_file;
    open my $in, '<:raw', $guidance_file or do {
        warn "cannot open guidance file: $!\n";
        return ('', '');
    };
    local $/;
    my $raw = <$in> // '';
    close $in;
    return ('', '') if length($raw) > 8192;
    my @directives;
    for my $line (split /\n/, $raw) {
        $line =~ s/\r\z//;
        next if $line =~ /^\s*(?:#|\z)/;
        if (length($line) > 220 || $line !~ /\A[\x20-\x7e]+\z/) {
            warn "ignored invalid guidance line\n";
            next;
        }
        my $valid =
            $line =~ /\ANOTE\|[^|]{1,180}\z/
            || $line =~ /\ARELOAD\|[^|]{1,180}\z/
            || $line =~ /\ACONTEXT\|(?:on|off)\z/
            || $line =~ /\AWATCH\|(?:all|[A-Za-z_][A-Za-z0-9_]*)\z/
            || $line eq 'INSPECT|all' || $line eq 'SCAN';
        if (!$valid) {
            warn "ignored unrecognized guidance directive\n";
            next;
        }
        push @directives, $line;
        last if @directives >= 24;
    }
    my $body = join("\n", @directives);
    return ($body, substr(sha256_hex($body), 0, 24));
};
my $send_plan = sub ($client) {
    return if !$active_revision;
    for my $line (split /\n/, $active_plan) {
        $client->write("APIDOCS|$active_revision|$line\n");
    }
};
if (defined $guidance_file) {
    ($active_plan, $active_revision) = $read_plan->();
}

my $listener = Linux::Event::IO::Sock::Listener->new(
    loop => $loop,
    host => '127.0.0.1',
    port => $port,
    stream => {
        class => 'VOAPI::Collector::Connection',
        on_ready => sub ($stream) {
            $clients{refaddr($stream)} = $stream;
            $send_plan->($stream);
        },
        on_close => sub ($stream) {
            delete $clients{refaddr($stream)};
        },
        on_message => sub ($stream, $record) {
            my $path = eval { $store->save($record) };
            if (!$path) {
                my $error = $@ || 'unknown capture error';
                $error =~ s/\s+\z//;
                warn "rejected record: $error\n";
                $stream->close;
                return;
            }
            say "saved $path";
        },
        on_error => sub ($stream, $error) {
            warn "client error: $error\n";
        },
    },
    on_error => sub ($listener, $error) {
        warn "listener error: $error\n";
    },
);

my ($guidance_timer, $flush_timer);
if (defined $guidance_file) {
    $guidance_timer = Linux::Event::Kernel::Timer->new(
        loop => $loop, after => 2, every => 2,
        on_timer => sub ($timer) {
            my ($plan, $rev) = $read_plan->();
            return if $rev eq $active_revision;
            ($active_plan, $active_revision) = ($plan, $rev);
            $send_plan->($_) for values %clients;
            say "loaded new guidance plan" if $rev;
        },
    );
    $flush_timer = Linux::Event::Kernel::Timer->new(
        loop => $loop, after => $flush_seconds, every => $flush_seconds,
        on_timer => sub ($timer) {
            $_->write("APIDOCS|FLUSH\n") for values %clients;
        },
    );
}

$| = 1;
say "VO API collector listening on 127.0.0.1:" . $listener->port;
say "Saving raw observations beneath " . $store->root;
say "Press Ctrl-C to stop.";
$loop->run;
