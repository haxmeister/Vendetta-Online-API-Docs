use v5.36;
use strict;
use warnings;
use FindBin;
use File::Spec;
use Test::More;

my $root = File::Spec->catdir($FindBin::Bin, '..');
my $index = File::Spec->catfile($root, 'docs', 'events', 'index.md');
open my $ifh, '<:encoding(UTF-8)', $index or die "$index: $!";
my $text = do { local $/; <$ifh> };
close $ifh;

my @events;
while ($text =~ /^\| \[\x60([^\x60]+)\x60\]\(\.\/([^)]*\.md)\) \| (.*?) \|$/mg) {
    push @events, [$1, $2, $3];
}
is(scalar @events, 214, 'historical index still contains 214 named event pages');

my %pages;
my $historical = 0;
for my $entry (@events) {
    my ($name, $file, $status) = @$entry;
    my $path = File::Spec->catfile($root, 'docs', 'events', $file);
    open my $fh, '<:encoding(UTF-8)', $path or die "$path: $!";
    my $page = do { local $/; <$fh> };
    close $fh;
    $pages{$name} = $page;
    if ($page =~ /^## Historical Racecar reference \(March 2024\)$/m) {
        $historical++;
        like($page, qr/Racecar Eventtype, revision 14149/, "source attribution: $name");
        like($page, qr/oldid=14149/, "stable historical source: $name");
        like($page, qr/^## Arguments\n/m, "observed/unknown arguments remain separate: $name");
    }
}
cmp_ok($historical, '>=', 71, 'source descriptions captured on at least 71 event pages');

like($pages{PLAYER_GOT_HIT},
    qr/Observed callback form: \x60\(number, number, number, boolean, number, userdata\)\x60/,
    'live six-position PLAYER_GOT_HIT retained despite shorter historical account');
like($pages{PLAYER_DIED},
    qr/Observed callback form: \x60\(number, number, number, number\)\x60/,
    'live four-position PLAYER_DIED retained');
like($pages{CHAT_MSG_SERVER_SECTOR},
    qr/Observed callback form: \x60\(table\)\x60/,
    'live table type overrides historic string description');
like($pages{MISSION_QUESTION_OPEN},
    qr/db:1009/, 'real mission token preserved');
like($pages{STORM_STOPPED},
    qr/arriving in a sector without an ion storm/i,
    'historical storm explanation preserved alongside observed zero-argument event');
like($pages{GROUP_MEMBER_KILLED},
    qr/^## Arguments\n\n\*\*Not yet observed\.\*\*/m,
    'historical group-kill argument guesses do not become observed signatures');
unlike($pages{GROUP_MEMBER_KILLED},
    qr/^\*\*Observed callback forms?:\*\*/m,
    'unobserved event still has no observed callback form');

my $crosswalk = File::Spec->catfile($root, 'docs', 'research', 'racecar-eventtype-crosswalk.md');
ok(-f $crosswalk, 'historical source and discrepancy crosswalk retained');
open my $cfh, '<:encoding(UTF-8)', $crosswalk or die "$crosswalk: $!";
my $cross = do { local $/; <$cfh> };
close $cfh;
like($cross, qr/Live captures govern the observed callback signatures/,
    'documented precedence rule favors live evidence');

done_testing;
