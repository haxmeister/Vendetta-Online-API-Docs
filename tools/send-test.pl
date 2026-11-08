#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use IO::Socket::INET;

my $port = 54000;
GetOptions('port=i' => \$port)
    or die "usage: perl tools/send-test.pl [--port 54000]\n";
die "invalid port\n" if $port < 1 || $port > 65535;

my $socket = IO::Socket::INET->new(
    PeerAddr => '127.0.0.1',
    PeerPort => $port,
    Proto    => 'tcp',
    Timeout  => 5,
) or die "connect to collector failed: $!\n";
binmode($socket, ':raw');

my @records = (
    "event\0SECTOR_LOADED\0First line\nSecond line\n",
    "snapshot\0globals\0GetPlayerName\tfunction\nRegisterEvent\tfunction\n",
    "note\0binary_test\0A\0B\nC:three\n",
);

# Deliberately split frames into small writes. TCP can also merge them.
my $wire = join '', map { length($_) . ':' . $_ } @records;
while (length $wire) {
    my $piece = substr($wire, 0, 7, '');
    my $offset = 0;
    while ($offset < length($piece)) {
        my $written = syswrite(
            $socket, $piece, length($piece) - $offset, $offset,
        );
        die "send failed: $!\n" if !defined($written) || !$written;
        $offset += $written;
    }
}

close($socket) or die "close failed: $!\n";
say "Sent " . scalar(@records) . " sample records; check captures/.";
