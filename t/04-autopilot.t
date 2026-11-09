use v5.36;
use strict;
use warnings;
use FindBin;
use File::Spec;
use Test::More;

my $repo = File::Spec->catdir($FindBin::Bin, '..');
for my $script (qw(assist.pl auto-publish.pl share-observations.pl)) {
    my $path = File::Spec->catfile($repo, 'tools', $script);
    ok(-f $path, "$script exists");
    is(system($^X, '-c', $path), 0, "$script compiles");
}
my $launcher = File::Spec->catfile($repo, 'tools', 'assist.pl');
is(system($^X, $launcher, '--help'), 0, 'assistant launcher exposes help');
my $plan = File::Spec->catfile($repo, 'control', 'plan.txt');
ok(-f $plan, 'declarative GitHub guidance plan exists');
open my $fh, '<', $plan or die $!;
while (my $line = <$fh>) {
    chomp $line;
    next if $line =~ /^#/ || $line =~ /^\s*$/;
    like($line, qr/\A(?:NOTE\|[^|]+|RELOAD\|[^|]+|CONTEXT\|(?:on|off)|WATCH\|(?:all|[A-Za-z_][A-Za-z0-9_]*)|INSPECT\|all|SCAN)\z/,
        'plan uses allowlisted directives, never arbitrary code');
}
close $fh;
done_testing;
