#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;
use FindBin;
use File::Spec;

# Import candidate identifiers from locally saved Racecar2 HTML/MediaWiki.
# These are names only, not verified API signatures or implementations.
my $source = shift @ARGV // die "usage: perl tools/import-candidates.pl saved-racecar2-index.html\n";
die "usage: perl tools/import-candidates.pl saved-racecar2-index.html\n" if @ARGV;
my $dest = File::Spec->catfile($FindBin::Bin, '..', 'data', 'function-candidates.txt');

open my $in, '<:raw', $source or die "cannot read $source: $!\n";
my $raw;
{ local $/; $raw = <$in>; }
close $in;

# Supports /index.php/API_Function and ?title=API_Function link shapes.
my %new;
while ($raw =~ /\bAPI_([A-Za-z_][A-Za-z0-9_]*)/g) {
    my $name = $1;
    next if $name =~ /\A(?:Index\d*|Main_Page|Events?|Categories|Category)\z/i;
    next if $name !~ /[a-z]/;
    $new{$name} = 1;
}
die "no API_Name links found in $source; please save the Racecar2 API index page as HTML\n"
    if !keys %new;

my %existing;
if (-e $dest) {
    open my $prior, '<', $dest or die "cannot read $dest: $!\n";
    while (my $line = <$prior>) {
        $line =~ s/\s*#.*\z//;
        $line =~ s/\A\s+|\s+\z//g;
        $existing{$line} = 1 if $line =~ /\A[A-Za-z_][A-Za-z0-9_]*\z/;
    }
    close $prior;
}

my @added = sort grep { !$existing{$_} } keys %new;
$existing{$_} = 1 for @added;

# Store just names, not third-party descriptions or HTML.
open my $out, '>', $dest or die "cannot write $dest: $!\n";
print {$out} "# Candidate identifiers from community references.\n";
print {$out} "# They may be missing, inaccessible, or obsolete in a current VO client.\n";
print {$out} "# Some candidates may come from the Racecar2 API index.\n";
print {$out} "$_\n" for sort keys %existing;
close $out or die "cannot finish $dest: $!\n";
say "Found " . scalar(keys %new) . " candidate identifiers; imported "
    . scalar(@added) . "; total " . scalar(keys %existing) . ".";
say "Next: perl tools/build-probes.pl";
