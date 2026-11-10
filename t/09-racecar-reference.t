use v5.36;
use strict;
use warnings;
use Test::More;
use FindBin;
use File::Spec;
use File::Basename qw(dirname);

my $repo = File::Spec->catdir($FindBin::Bin, '..');
my $functions = File::Spec->catdir($repo, 'docs', 'functions');
my $tables = File::Spec->catdir($repo, 'docs', 'tables');
my @functions = glob(File::Spec->catfile($functions, '*.md'));
my @tables = glob(File::Spec->catfile($tables, '*.md'));
@functions = grep { !/\/index\.md\z|\/observed-getters\.md\z/ } @functions;
@tables = grep { !/\/index\.md\z/ } @tables;
is(scalar @functions, 584, 'all 584 Racecar-based function pages are present');
is(scalar @tables, 63, 'all 63 Index2 table pages are present');

sub read_file ($path) {
    open my $in, '<:raw', $path or die "$path: $!";
    local $/;
    my $text = <$in>;
    close $in;
    return $text;
}

my $function_index = read_file(File::Spec->catfile($functions, 'index.md'));
my $table_index = read_file(File::Spec->catfile($tables, 'index.md'));
for my $entry (@functions) {
    my ($name) = $entry =~ m{/([^/]+)\.md\z};
    my $content = read_file($entry);
    like($content, qr/\A# \Q$name\E\n/, "$name has its individual heading");
    like($content, qr/## Historical Racecar signature\n/, "$name distinguishes historical signature");
    like($content, qr/## Evidence and limitations/, "$name has source and limitations");
    like($function_index, qr/\.\/\Q$name\E\.md/, "$name is linked from index");
}
for my $entry (@tables) {
    my ($name) = $entry =~ m{/([^/]+)\.md\z};
    my $content=read_file($entry);
    like($content, qr/\A# \Q$name\E\n/, "$name has its individual heading");
    like($content, qr/Historical Racecar/, "$name is clearly historical");
    like($content, qr/## Evidence and limitations/, "$name cites historical source");
    like($table_index, qr/\.\/\Q$name\E\.md/, "$name is linked from index");
}

my $target = read_file(File::Spec->catfile($functions, 'GetTargetInfo.md'));
like($target, qr/seven values with asteroid or NPC/, 'GetTargetInfo live 7-field evidence wins');
like($target, qr/historical detail page lists six fields/i, 'GetTargetInfo acknowledges historical disagreement');
my $speed=read_file(File::Spec->catfile($functions, 'GetActiveShipSpeed.md'));
like($speed, qr/46\.928863525391/, 'fractional live speed retained');
my $health=read_file(File::Spec->catfile($functions, 'GetActiveShipHealth.md'));
like($health, qr/number × 8, nil, nil/, 'ten-position live health signature retained');
like($health, qr/shield values/, 'historical optional shield meaning preserved');
my $nav=read_file(File::Spec->catfile($tables, 'NavRoute.md'));
like($nav, qr/`SetFinalDestination`/, 'NavRoute method list preserved');
my $guild=read_file(File::Spec->catfile($tables, 'Guild.md'));
like($guild, qr/`getbankbalance`/, 'Guild method names preserved');
my $socket=read_file(File::Spec->catfile($tables, 'TCPSocket.md'));
like($socket, qr/`SetReadHandler`/, 'TCPSocket asynchronous method names preserved');
my $vars=read_file(File::Spec->catfile($repo, 'docs', 'variables', 'index.md'));
like($vars, qr/`CLASSTYPE_ADDON`/, 'historical variables included');
unlike($vars, qr/\| `This` \|/, 'source footer is not treated as a variable');

done_testing;
