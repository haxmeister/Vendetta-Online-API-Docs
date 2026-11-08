#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
use Getopt::Long qw(GetOptions);
use File::Spec;
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
my $help;
GetOptions(
    'port=i' => \$port,
    'out=s'  => \$out,
    'help'   => \$help,
) or die "usage: perl tools/collect.pl [--port 54000] [--out captures]\n";

if ($help) {
    say 'usage: perl tools/collect.pl [--port 54000] [--out captures]';
    exit 0;
}
die "port must be between 1 and 65535\n"
    if $port < 1 || $port > 65535;

umask 0077;
my $store = VOAPI::Collector->new(root => $out);
my $loop = Linux::Event::Loop->new;

my $listener = Linux::Event::IO::Sock::Listener->new(
    loop => $loop,
    host => '127.0.0.1',
    port => $port,
    stream => {
        class => 'VOAPI::Collector::Connection',
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

$| = 1;
say "VO API collector listening on 127.0.0.1:" . $listener->port;
say "Saving raw observations beneath " . $store->root;
say "Press Ctrl-C to stop.";
$loop->run;
