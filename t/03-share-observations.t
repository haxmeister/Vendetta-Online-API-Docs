use v5.36;
use strict;
use warnings;
use FindBin;
use File::Path qw(make_path);
use File::Spec;
use File::Temp qw(tempdir);
use Test::More;

my $tmp = tempdir(CLEANUP => 1);
my $captures = File::Spec->catdir($tmp, 'captures');
my $report = File::Spec->catfile($tmp, 'report.md');
my $tool = File::Spec->catfile($FindBin::Bin, '..', 'tools', 'share-observations.pl');

sub write_capture ($kind, $name, $filename, $body) {
    my $dir = File::Spec->catdir($captures, $kind, $name);
    make_path($dir);
    my $path = File::Spec->catfile($dir, $filename);
    open my $out, '>:raw', $path or die "$path: $!";
    print {$out} $body;
    close $out or die "$path: $!";
}
write_capture('function', 'GetTargetInfo', '20261108T210001.000000Z-123-000001.txt', <<'CAPTURE');
format=api-inspect-v1
source=approved-no-arg
function=GetTargetInfo
result=ok
returns=3
return1 type=string bytes=11
return2 type=nil
return3 type=number value=12345
CAPTURE
write_capture('function', 'GetTargetDistance', '20261108T210001.000000Z-123-000002.txt', <<'CAPTURE');
format=api-inspect-v1
source=approved-no-arg
function=GetTargetDistance
result=error
error="player secret error"
CAPTURE
write_capture('event', 'CHAT_MSG_PRIVATE', '20261108T210001.000000Z-123-000003.txt', <<'CAPTURE');
event=CHAT_MSG_PRIVATE
arguments=2
arg1 type=string value="secret player"
arg2 type=table value=table{"private":"string"}
CAPTURE
write_capture('note', 'connection_test', '20261108T210001.000000Z-123-000004.txt',
    "private text should never be published\n");

is(system($^X, $tool, '--captures', $captures, '--output', $report), 0,
    'generates local sanitized report');
ok(-f $report, 'report exists');
open my $in, '<', $report or die "$report: $!";
my $text = do { local $/; <$in> };
close $in;
like($text, qr/GetTargetInfo \| ok: 3 returns \(string, nil, number\)/,
    'preserves return count and nil position');
like($text, qr/GetTargetDistance \| error \(details omitted\)/,
    'preserves errors without error text');
like($text, qr/CHAT_MSG_PRIVATE \| 2 args \(string, table\)/,
    'preserves event argument types');
unlike($text, qr/secret player|player secret error|private text|12345/,
    'never includes sensitive content or scalar values');
like($text, qr/Function inspection records: 2/,
    'function count');
like($text, qr/Event observation records: 1/,
    'event count');
done_testing;
