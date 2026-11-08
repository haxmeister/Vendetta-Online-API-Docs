use v5.36;
use strict;
use warnings;
use FindBin;
use File::Path qw(make_path);
use File::Copy qw(copy);
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
return1 type=string value="an NPC" bytes=6
return2 type=nil
return3 type=number value=12345
CAPTURE
write_capture('function', 'GetTargetDistance', '20261108T210001.000000Z-123-000002.txt', <<'CAPTURE');
format=api-inspect-v1
source=approved-no-arg
function=GetTargetDistance
result=error
error="sample native error"
CAPTURE
write_capture('event', 'CHAT_MSG_PRIVATE', '20261108T210001.000000Z-123-000003.txt', <<'CAPTURE');
event=CHAT_MSG_PRIVATE
arguments=2
arg1 type=string value="private hello from a player"
arg2 type=table value=table{"sender":"string", "message":"string"}
CAPTURE
write_capture('event', 'CHAT_ENTERED', '20261108T210001.000000Z-123-000004.txt', <<'CAPTURE');
event=CHAT_ENTERED
arguments=1
arg1 type=string value="typed in chat"
CAPTURE
write_capture('event', 'TARGET_CHANGED', '20261108T210001.000000Z-123-000005.txt', <<'CAPTURE');
event=TARGET_CHANGED
arguments=1
arg1 type=string value="asteroid"
CAPTURE
write_capture('snapshot', 'functions', '20261108T210001.000000Z-123-000006.txt', <<'CAPTURE');
format=api-probe-v1
candidate_count=398
GetTargetInfo	function
CAPTURE
write_capture('note', 'connection_test', '20261108T210001.000000Z-123-000007.txt',
    "Test note keeps this text\nSecond line\n");

is(system($^X, $tool, '--captures', $captures, '--output', $report), 0,
    'generates report preserving non-chat observations');
ok(-f $report, 'report exists');
open my $in, '<:raw', $report or die "$report: $!";
my $text = do { local $/; <$in> };
close $in;
like($text, qr/return1 type=string value="an NPC" bytes=6/,
    'preserves recorded string contents');
like($text, qr/return3 type=number value=12345/,
    'preserves numerical results');
like($text, qr/error="sample native error"/, 'preserves errors');
like($text, qr/TARGET_CHANGED.*?asteroid/s,
    'preserves non-chat event strings');
like($text, qr/candidate_count=398/, 'preserves snapshot inventory');
like($text, qr/Test note keeps this text/, 'preserves notes');
like($text, qr/CHAT_MSG_PRIVATE.*?arguments=2.*?arg1 type=string/s,
    'keeps chat event and argument types');
unlike($text, qr/private hello from a player|typed in chat|sender.*message/s,
    'redacts chat values including table preview');
like($text, qr/Chat event payloads redacted: 2/,
    'counts chat redactions');
like($text, qr/Function records: 2/, 'function count');
like($text, qr/Event records: 3/, 'event count');
like($text, qr/Snapshots: 1/, 'snapshot count');
like($text, qr/Notes: 1/, 'note count');
# The default handoff should skip recordings already promoted to docs.
my $isolated = File::Spec->catdir($tmp, 'isolated');
my $isolated_tools = File::Spec->catdir($isolated, 'tools');
my $isolated_data = File::Spec->catdir($isolated, 'data');
make_path($isolated_tools, $isolated_data);
my $isolated_script = File::Spec->catfile($isolated_tools, 'share-observations.pl');
ok(copy($tool, $isolated_script), 'copy tool for default-path cutoff test');
open my $reviewed, '>', File::Spec->catfile($isolated_data, 'reviewed-through.txt')
    or die $!;
print {$reviewed} "# latest extracted capture\n20261108T220410.123515Z\n";
close $reviewed;
my $default_dir = File::Spec->catdir($isolated, 'captures', 'function', 'GetCurrentSectorid');
make_path($default_dir);
for my $example (
    ['20261108T220409.000000Z-1-000001.txt', 13],
    ['20261108T220411.000000Z-1-000002.txt', 22],
) {
    my $file = File::Spec->catfile($default_dir, $example->[0]);
    open my $out, '>', $file or die $!;
    print {$out} "format=api-inspect-v1\nfunction=GetCurrentSectorid\n",
        "result=ok\nreturns=1\nreturn1 type=number value=$example->[1]\n";
    close $out;
}
is(system($^X, $isolated_script), 0, 'default report respects review cutoff');
my $isolated_report = File::Spec->catfile($isolated, 'docs', 'research', 'capture-summary.md');
open my $r, '<', $isolated_report or die $!;
my $cutoff_text = do { local $/; <$r> };
close $r;
like($cutoff_text, qr/value=22/, 'keeps newer capture values');
unlike($cutoff_text, qr/value=13/, 'excludes already reviewed capture');
is(system($^X, $isolated_script, '--all'), 0, '--all overrides review cutoff');
open $r, '<', $isolated_report or die $!;
my $all_text = do { local $/; <$r> };
close $r;
like($all_text, qr/value=13/, '--all restores older values');

done_testing;
