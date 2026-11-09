use v5.36;
use strict;
use warnings;
use Archive::Tar;
use File::Path qw(make_path);
use File::Spec;
use File::Temp qw(tempdir);
use FindBin;
use IO::Socket::INET;
use JSON::PP;
use Test::More;

my $temp = tempdir(CLEANUP => 1);
my $output = File::Spec->catdir($temp, 'Documents');
my $cache = File::Spec->catdir($temp, 'cache');
my $seed = File::Spec->catfile($temp, 'seed.tsv');
my $log = File::Spec->catfile($temp, 'requests.txt');
make_path($output);

my $listener=IO::Socket::INET->new(
    LocalAddr=>'127.0.0.1', LocalPort=>0, Listen=>8, ReuseAddr=>1,
) or plan skip_all => "loopback TCP unavailable: $!";
my $port=$listener->sockport;
my $base="http://127.0.0.1:$port/racecar2/index.php";

open my $seeds, '>', $seed or die $!;
for (1..8) {
    print {$seeds} "function\tFailure$_\t$base/API_Failure$_\tlinked\n";
}
close $seeds;

my $server=fork();
defined $server or plan skip_all => "fork failed: $!";
if (!$server) {
    $SIG{TERM} = sub { exit 0 };
    while (my $connection=$listener->accept) {
        my $request=<$connection> // '';
        my ($path)=$request =~ m{^GET\s+(\S+)};
        while (defined(my $header=<$connection>)) {
            last if $header =~ /^\r?\n$/;
        }
        open my $out, '>>', $log or die $!;
        print {$out} ($path // 'unknown'), "\n";
        close $out;
        if (($path//'') =~ /API_Index2/) {
            # Simulate a transport failure: drop the connection without headers.
            close $connection;
            next;
        }
        my $body="Request rejected by fixture";
        print {$connection} "HTTP/1.1 418 Blocked\r\n"
            . "Content-Type: text/plain\r\n"
            . "Content-Length: " . length($body) . "\r\n"
            . "Connection: close\r\n\r\n$body";
        close $connection;
    }
    exit 0;
}
close $listener;

END {
    if (defined($server) && $server > 0) {
        kill 'TERM', $server;
        waitpid $server, 0;
    }
}

my $crawler=File::Spec->catfile($FindBin::Bin,'..','tools','crawl-racecar.pl');
# HTTP::Tiny interprets existing proxy keys differently from absent
# keys, even when their values are undef. Delete them for a clean fixture.
delete @ENV{qw(http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY)};
local $ENV{no_proxy} = 'localhost,127.0.0.1';
local $ENV{NO_PROXY} = 'localhost,127.0.0.1';

sub invoke ($label,@args) {
    my $logfile=File::Spec->catfile($temp,"$label.log");
    my $child=fork();
    die "fork script: $!" unless defined $child;
    if (!$child) {
        open STDOUT, '>', $logfile or die $!;
        open STDERR, '>&', \*STDOUT or die $!;
        exec $^X, $crawler, @args;
        die "exec crawler: $!";
    }
    waitpid $child, 0;
    my $exit=$? >> 8;
    open my $fh, '<', $logfile or die $!;
    my $message=do { local $/; <$fh> };
    close $fh;
    return ($exit,$message);
}
my @common=(
    '--seed-file',$seed, '--output-dir',$output, '--cache-dir',$cache,
    '--allow-host','127.0.0.1', '--index-url',"$base/API_Index2",
    '--delay','0', '--timeout','3',
);

my ($diagnostic_exit,$diagnostic_output)=invoke('diagnostic',@common,'--diagnose');
is($diagnostic_exit,2,'one-request diagnostic exits on transport failure');
like($diagnostic_output,qr/FAIL: 599: Internal Exception:/,
    'real HTTP::Tiny transport exception details included');
like($diagnostic_output,qr/transport exception, not a server HTTP status/,
    '599 distinguished from a server HTTP response');
my @archives=glob(File::Spec->catfile($output,'Racecar-API-*.tar.gz'));
is(scalar @archives,0,'diagnostic mode does not create a tarball');

my ($crawl_exit,$crawl_output)=invoke('failfast',@common,'--no-index',
    '--max-consecutive-errors','3');
is($crawl_exit,2,'crawl with no successful pages reports failure');
like($crawl_output,qr/Stopping requests after 3 consecutive failures/,
    'aborted crawl explains why it stopped');
like($crawl_output,qr/\b418: Blocked\b/,
    'HTTP error reason is visible to user');
@archives=glob(File::Spec->catfile($output,'Racecar-API-*.tar.gz'));
is(scalar @archives,1,'failed crawl still generates diagnostic archive');
my $tar=Archive::Tar->new;
ok($tar->read($archives[0],1),'diagnostic tarball is readable');
my $manifest=decode_json($tar->get_content('racecar-api/manifest.json'));
is($manifest->{stats}{failed},3,'only three pages were attempted and failed');
is($manifest->{stats}{not_attempted_connection_errors},5,
    'remaining pages marked unattempted due to failure limit');
ok($manifest->{stats}{stopped_early},'manifest records the early stop');
is($manifest->{stats}{requests},3,'three requests made, no retries for 418');

open my $requests,'<',$log or die $!;
my @requests=<$requests>;
close $requests;
is(scalar @requests,4,'one diagnostic plus three crawl HTTP requests');
unlike(join('',@requests),qr/robots\.txt|llms\.txt/,
    'crawler never fetched robots or llms');

done_testing;
