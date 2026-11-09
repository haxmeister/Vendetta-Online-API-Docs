use v5.36;
use strict;
use warnings;
use FindBin;
use File::Spec;
use Test::More;

my $root = File::Spec->catdir($FindBin::Bin, '..');
my $index_path = File::Spec->catfile($root, 'docs', 'events', 'index.md');
open my $index_fh, '<:encoding(UTF-8)', $index_path or die "$index_path: $!";
my $index = do { local $/; <$index_fh> };
close $index_fh;

my @entries;
while ($index =~ /^\| \[\x60([^\x60]+)\x60\]\(\.\/([^)]*\.md)\) \| (.*?) \|$/mg) {
    push @entries, [$1, $2, $3];
}
cmp_ok(scalar @entries, '>=', 200, 'index lists historical event candidates');

my (%seen, $observed, $unobserved);
for my $entry (@entries) {
    my ($name, $file, $status) = @$entry;
    ok(!$seen{$name}++, "$name occurs once in the index");
    like($file, qr/\A[A-Za-z0-9_]+\.md\z/, "$name links to an event page");
    my $path = File::Spec->catfile($root, 'docs', 'events', $file);
    open my $fh, '<:encoding(UTF-8)', $path or die "$path: $!";
    my $page = do { local $/; <$fh> };
    close $fh;

    like($page,
        qr/\A\# \Q$name\E\n\n\*\*Status:\*\* [^\n]+\n\n\#\# Arguments\n\n/,
        "$name places the argument summary immediately after its status");

    if ($status =~ /not yet observed/i) {
        $unobserved++;
        like($page, qr/^## Arguments\n\n\*\*Not yet observed\.\*\*/m,
            "$name does not invent a signature");
        unlike($page, qr/^\*\*Observed callback forms?:\*\*/m,
            "$name has no observed form");
    }
    else {
        $observed++;
        like($page, qr/^## Arguments\n\n\*\*Observed callback forms?:\*\* /m,
            "$name identifies its observed forms");
        my $table = $page =~ /^\| Position \| Lua type\(s\) \| Meaning \| Recorded example\(s\) \| Meaning confidence \|$/m;
        my $zero  = $page =~ /^No positional callback arguments were observed\.$/m;
        ok($table || $zero, "$name has positional details or an explicit no-arguments statement");
    }
}
cmp_ok($observed, '>', 0, 'observed pages checked');
cmp_ok($unobserved, '>', 0, 'unobserved pages checked');

done_testing;
