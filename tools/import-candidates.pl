#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;
use FindBin;
use File::Spec;

# Import *names only* from a saved Racecar2 function index.
# Accept either pasted/plain text (Functions ... Tables sections) or HTML
# containing API_FunctionName wiki links. Descriptions remain at source.
my $source = shift @ARGV
    // die "usage: perl tools/import-candidates.pl racecar2-function-index.txt|html\n";
die "usage: perl tools/import-candidates.pl racecar2-function-index.txt|html\n"
    if @ARGV;
my $dest = File::Spec->catfile(
    $FindBin::Bin, '..', 'data', 'function-candidates.txt'
);

open my $in, '<:raw', $source or die "cannot read $source: $!\n";
my $raw;
{ local $/; $raw = <$in>; }
close $in;

my %found;
my @lines = split /\r?\n/, $raw;
my $in_functions = 0;
my $found_section = 0;
for my $line (@lines) {
    if (!$in_functions) {
        if ($line =~ /^\s*Functions\s*$/) {
            $in_functions = 1;
            $found_section = 1;
        }
        next;
    }
    last if $line =~ /^\s*Tables\s*$/;
    next if $line =~ /^\s*$/;
    # Match a leading Lua identifier followed by a signature/description
    # marker. This excludes names appearing only in descriptions.
    if ($line =~ /^\s*([A-Za-z_][A-Za-z0-9_]*)\s*(?=\(|\{|->|::)/) {
        $found{$1} = 1;
    }
}

if (!$found_section) {
    # Saved HTML: extract explicit API_ links only. A link in the function
    # index can still point to an obsolete or unrelated entry: inspect names.
    while ($raw =~ /\bAPI_([A-Za-z_][A-Za-z0-9_]*)/g) {
        my $name = $1;
        next if $name =~ /\A(?:Index\d*|Main_Page|Events?|Categories|Category)\z/i;
        next if $name !~ /[a-z]/; # Skip all-caps event names.
        $found{$name} = 1;
    }
}

die "no candidate names found; save the Function Index as text or HTML\n"
    if !keys %found;

my %candidates;
if (-e $dest) {
    open my $prior, '<', $dest or die "cannot read $dest: $!\n";
    while (my $line = <$prior>) {
        $line =~ s/\s*#.*\z//;
        $line =~ s/\A\s+|\s+\z//g;
        $candidates{$line} = 1
            if $line =~ /\A[A-Za-z_][A-Za-z0-9_]*\z/;
    }
    close $prior;
}
my @added = sort grep { !$candidates{$_} } keys %found;
$candidates{$_} = 1 for @added;

open my $out, '>', $dest or die "cannot write $dest: $!\n";
print {$out} "# Candidate identifiers from community function references.\n";
print {$out} "# Names only, not verified signatures or current availability.\n";
print {$out} "# Racecar2 reference may be outdated; protected reads never call functions.\n";
print {$out} "$_\n" for sort keys %candidates;
close $out or die "cannot finish $dest: $!\n";

say "Found " . scalar(keys %found) . " names in source; imported "
    . scalar(@added) . "; total " . scalar(keys %candidates) . ".";
say "Next: perl tools/build-probes.pl";
