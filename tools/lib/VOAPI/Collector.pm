package VOAPI::Collector;
use v5.36;
use strict;
use warnings;

use Carp qw(croak);
use Errno qw(EEXIST EINTR);
use Fcntl qw(O_CREAT O_EXCL O_WRONLY);
use File::Path qw(make_path);
use File::Spec;
use Time::HiRes qw(gettimeofday);

our $MAX_RECORD = 262_144;

my %CATEGORY = map { $_ => 1 } qw(event function snapshot note);

sub new ($class, %opt) {
    my $root = delete $opt{root} // croak 'root is required';
    croak 'unknown options: ' . join(', ', sort keys %opt) if %opt;
    croak 'root must be a directory path' if ref($root) || $root eq '';

    $root = File::Spec->rel2abs($root);
    make_path($root, { mode => 0700 });
    return bless { root => $root, sequence => 0 }, $class;
}

sub root ($self) { $self->{root} }

# Message: category NUL name NUL arbitrary bytes
# Only the first two NULs separate fields; the body remains unchanged.
sub save ($self, $record) {
    croak 'record is required' if !defined $record;
    croak 'record exceeds maximum size' if length($record) > $MAX_RECORD;

    my $first = index($record, "\0");
    croak 'missing category separator' if $first < 0;
    my $second = index($record, "\0", $first + 1);
    croak 'missing name separator' if $second < 0;

    my $category = substr($record, 0, $first);
    my $name = substr($record, $first + 1, $second - $first - 1);
    my $body = substr($record, $second + 1);

    croak 'invalid category' if !$CATEGORY{$category};
    croak 'invalid record name'
        if $name !~ /\A[A-Za-z_][A-Za-z0-9_.-]{0,119}\z/;

    my $directory = File::Spec->catdir($self->{root}, $category, $name);
    make_path($directory, { mode => 0700 });

    my ($seconds, $microseconds) = gettimeofday();
    my @utc = gmtime($seconds);
    my $stamp = sprintf(
        '%04d%02d%02dT%02d%02d%02d.%06dZ',
        $utc[5] + 1900, $utc[4] + 1, $utc[3],
        $utc[2], $utc[1], $utc[0], $microseconds,
    );

    my ($fh, $path);
    for (1 .. 100) {
        my $file = sprintf(
            '%s-%d-%06d.txt', $stamp, $$, ++$self->{sequence},
        );
        $path = File::Spec->catfile($directory, $file);
        last if sysopen($fh, $path, O_WRONLY | O_CREAT | O_EXCL, 0600);
        croak "cannot create capture: $!" if $! != EEXIST;
    }
    croak 'could not find an unused capture filename' if !$fh;

    binmode($fh, ':raw');
    my $ok = eval {
        my $offset = 0;
        while ($offset < length($body)) {
            my $written = syswrite(
                $fh, $body, length($body) - $offset, $offset,
            );
            next if !defined($written) && $! == EINTR;
            die "capture write failed: $!\n" if !defined $written;
            die "capture write returned zero bytes\n" if !$written;
            $offset += $written;
        }
        close($fh) or die "capture close failed: $!\n";
        1;
    };
    if (!$ok) {
        my $error = $@ || 'capture failed';
        close($fh) if defined(fileno($fh));
        unlink($path);
        die $error;
    }

    return $path;
}

1;
