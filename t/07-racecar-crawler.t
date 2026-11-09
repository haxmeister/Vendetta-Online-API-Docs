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

my $root = tempdir(CLEANUP => 1);
my $out = File::Spec->catdir($root, 'Documents');
my $cache = File::Spec->catdir($root, 'cache');
my $fixture = File::Spec->catfile($root, 'seed.tsv');
my $requests = File::Spec->catfile($root, 'requests.txt');
make_path($out);

my $listener = IO::Socket::INET->new(
    LocalAddr => '127.0.0.1', LocalPort => 0,
    Listen => 8, ReuseAddr => 1,
) or plan skip_all => "cannot create loopback HTTP server: $!";
my $port = $listener->sockport;
my $base = "http://127.0.0.1:$port/racecar2/index.php";
open my $seeds, '>', $fixture or die $!;
print {$seeds} "function\tExampleFunction\t$base/API_ExampleFunction\tlinked\n";
print {$seeds} "table\tSampleTable\t$base/SampleTable\tlinked\n";
print {$seeds} "table\tMissingTable\t$base?title=MissingTable&action=edit&redlink=1\tmissing\n";
close $seeds;

my $pid = fork();
if (!defined $pid) { plan skip_all => "fork failed: $!"; }
if (!$pid) {
    $SIG{TERM} = sub { exit 0 };
    while (my $client = $listener->accept) {
        my $request = <$client> // '';
        my ($path) = $request =~ m{^GET\s+(\S+)};
        while (defined(my $line = <$client>)) { last if $line =~ /^\r?\n$/; }
        if (defined $path) {
            open my $log, '>>', $requests or die $!;
            print {$log} "$path\n";
            close $log;
        }
        my %responses = (
            '/racecar2/index.php/API_Index2' => q{<html><body><div id="mw-content-text"><p>Index</p><a href="/racecar2/index.php/API_NewFunction">NewFunction</a><a href="/racecar2/index.php?title=Missing&action=edit&redlink=1">redlink</a><a href="https://example.com/outside">other host</a></div></body></html>},
            '/racecar2/index.php/API_ExampleFunction' => q{<html><body><div id="mw-content-text"><h1>ExampleFunction</h1><p>Tests table lookup.</p><pre>return {station = 42}</pre></div></body></html>},
            '/racecar2/index.php/API_NewFunction' => q{<html><body><div id="mw-content-text"><h1>NewFunction</h1><p>Discovered from live index.</p></div></body></html>},
            '/racecar2/index.php/SampleTable' => q{<html><body><div id="mw-content-text"><h1>SampleTable</h1><p><b>keys</b> in example:</p><table><tr><th>key</th><th>type</th></tr><tr><td>station</td><td>number</td></tr></table></div></body></html>},
        );
        my $body = $responses{$path};
        my $status = defined $body ? '200 OK' : '404 Not Found';
        $body //= '<html><body>Not found</body></html>';
        print {$client} "HTTP/1.1 $status\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: ".length($body)."\r\nConnection: close\r\n\r\n$body";
        close $client;
    }
    exit 0;
}
close $listener;
END { kill 'TERM', $pid if defined($pid) && $pid > 0; }

my $tool = File::Spec->catfile($FindBin::Bin, '..', 'tools', 'crawl-racecar.pl');
local $ENV{no_proxy} = 'localhost,127.0.0.1';
local $ENV{NO_PROXY} = 'localhost,127.0.0.1';
local $ENV{http_proxy};
local $ENV{https_proxy};
local $ENV{all_proxy};
local $ENV{HTTP_PROXY};
local $ENV{HTTPS_PROXY};
local $ENV{ALL_PROXY};
my @args = (
    $^X, $tool, '--seed-file', $fixture, '--output-dir', $out,
    '--cache-dir', $cache, '--allow-host', '127.0.0.1',
    '--index-url', "$base/API_Index2", '--delay', '0', '--timeout', '5',
);
is(system(@args), 0, 'crawler downloads index and pages and creates archive');
my @archives = glob(File::Spec->catfile($out, 'Racecar-API-*.tar.gz'));
is(scalar @archives, 1, 'one tarball is written to Documents');
my $archive = $archives[0];
my $tar = Archive::Tar->new;
ok($tar->read($archive, 1), 'tarball is readable');
my @files = $tar->list_files;
ok(grep({$_ eq 'racecar-api/pages/functions/ExampleFunction.html'} @files), 'function HTML stored');
ok(grep({$_ eq 'racecar-api/pages/functions/NewFunction.html'} @files), 'new link from current index followed');
ok(grep({$_ eq 'racecar-api/pages/tables/SampleTable.html'} @files), 'table HTML stored');
ok(grep({$_ eq 'racecar-api/pages/functions/ExampleFunction.txt'} @files), 'readable text stored');
my $manifest = decode_json($tar->get_content('racecar-api/manifest.json'));
is($manifest->{stats}{saved}, 3, 'all linked pages downloaded');
is($manifest->{stats}{unlinked_pdf}, 1, 'historical redlink recorded without fetching');
is($manifest->{stats}{failed}, 0, 'no HTTP failures');
like($tar->get_content('racecar-api/pages/functions/ExampleFunction.txt'), qr/return \{station = 42\}/, 'code examples retained in extracted text');
like($tar->get_content('racecar-api/pages/tables/SampleTable.txt'), qr/station/, 'table key retained in extracted text');
open my $fh, '<', $requests or die $!;
my @reqs = <$fh>;
close $fh;
is(scalar @reqs, 4, 'one request per index or page');
unlike(join('', @reqs), qr/robots\.txt|llms\.txt|MissingTable|example\.com/, 'no robots, llms, dead links or external domains requested');

is(system(@args), 0, 'second run reuses cached pages');
@archives = glob(File::Spec->catfile($out, 'Racecar-API-*.tar.gz'));
$tar = Archive::Tar->new;
ok($tar->read($archives[-1], 1), 'cached tarball remains readable');
$manifest = decode_json($tar->get_content('racecar-api/manifest.json'));
is($manifest->{stats}{requests}, 0, 'cache avoids repeat HTTP fetches');
is($manifest->{stats}{cache_hits}, 4, 'all pages and index served from cache');

kill 'TERM', $pid;
waitpid $pid, 0;
done_testing;