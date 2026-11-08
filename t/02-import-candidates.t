use v5.36;
use strict;
use warnings;
use File::Path qw(make_path);
use File::Spec;
use File::Temp qw(tempdir);
use Test::More;

my $temp = tempdir(CLEANUP => 1);
my $tools = File::Spec->catdir($temp, 'tools');
my $data = File::Spec->catdir($temp, 'data');
make_path($tools, $data);
my $source_script = File::Spec->catfile('tools', 'import-candidates.pl');
my $script = File::Spec->catfile($tools, 'import-candidates.pl');
{
    open my $in, '<', $source_script or die $!;
    open my $out, '>', $script or die $!;
    print {$out} $_ while <$in>;
    close $out;
    close $in;
}
my $seed = File::Spec->catfile($data, 'function-candidates.txt');
open my $seed_fh, '>', $seed or die $!;
print {$seed_fh} "# existing\nRegisterEvent\n";
close $seed_fh;

my $plain = File::Spec->catfile($temp, 'wiki.txt');
open my $fh, '>', $plain or die $!;
print {$fh} <<'TEXT';
Interface
AdditionalHUDText
General
Functions
GetCurrentSectorid() -> int :: sector
JoinChannel{channelid1 ..} -> nil :: join
GetPlayerNodeID(int charid) -> int
GetPlayerNodeID(int charid) -> int
assert :: [1]
Tables
SystemNames :: array
Variables
Platform -> Unix
TEXT
close $fh;

is(system($^X, $script, $plain), 0, 'imports plain-text index');
my @names = get_names($seed);
is_deeply(\@names, [qw(GetCurrentSectorid GetPlayerNodeID JoinChannel RegisterEvent assert)],
    'only unique function names, preserving existing candidates');
is(system($^X, $script, $plain), 0, 'repeat import succeeds');
is_deeply([get_names($seed)], \@names, 'import is idempotent');

my $html = File::Spec->catfile($temp, 'wiki.html');
open $fh, '>', $html or die $!;
print {$fh} '<a href="/index.php/API_GetTargetDistance">x</a>', "\n";
print {$fh} '<a href="?title=API_RegisterEvent">x</a>', "\n";
print {$fh} '<a href="/index.php/API_Index">Index</a>', "\n";
close $fh;
is(system($^X, $script, $html), 0, 'imports HTML API links');
@names = get_names($seed);
ok(grep($_ eq 'GetTargetDistance', @names), 'HTML function name imported');
ok(!grep($_ eq 'Index', @names), 'index link excluded');

done_testing;

sub get_names ($path) {
    open my $in, '<', $path or die $!;
    my @items = grep { $_ ne '' && $_ !~ /^#/ } map { s/\s+\z//r } <$in>;
    close $in;
    return @items;
}
