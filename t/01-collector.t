use v5.36;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../tools/lib";
use File::Temp qw(tempdir);
use Test::More;
use VOAPI::Collector;

my $root = tempdir(CLEANUP => 1);
my $collector = VOAPI::Collector->new(root => $root);

my $body = "First line\nSecond line\0with a NUL\n";
my $path = $collector->save("event\0SECTOR_LOADED\0" . $body);
ok(-f $path, 'event observation saved');
open my $fh, '<:raw', $path or die "open: $!";
local $/;
is(<$fh>, $body, 'body survives newlines and NUL bytes unchanged');
close $fh;

my $next_path = $collector->save("event\0SECTOR_LOADED\0" . $body);
isnt($next_path, $path, 'capture names are unique');
ok(-f $next_path, 'second capture preserved');

my $empty_path = $collector->save("function\0GetPlayerName\0");
is(-s $empty_path, 0, 'empty observation is allowed');

for my $invalid (
    [ "invalid\0test\0text",          qr/invalid category/,          'reject unknown category' ],
    [ "event\0../escape\0text",       qr/invalid record name/,       'reject path traversal' ],
    [ "event\0slash/name\0text",      qr/invalid record name/,       'reject directory separators' ],
    [ "event\0name-only",             qr/missing name separator/,    'reject incomplete record' ],
    [ "missing all separators",       qr/missing category separator/,'reject unstructured record' ],
    [ "event\0Name\0" . ('x' x 262_145), qr/exceeds maximum size/,   'reject oversized records' ],
) {
    my ($message, $expected, $description) = @$invalid;
    my $ok = eval { $collector->save($message); 1 };
    ok(!$ok, $description);
    like($@, $expected, 'reports expected validation error');
}

done_testing;
