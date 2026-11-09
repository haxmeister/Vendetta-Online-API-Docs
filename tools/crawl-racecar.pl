#!/usr/bin/env perl
use v5.36;
use strict;
use warnings;
use Archive::Tar;
use Digest::SHA qw(sha256_hex);
use File::Find qw(find);
use File::Path qw(make_path);
use File::Spec;
use File::Temp qw(tempdir);
use FindBin;
use Getopt::Long qw(GetOptions);
use HTML::TreeBuilder;
use HTTP::Tiny;
use JSON::PP;
use POSIX qw(strftime);
use Time::HiRes qw(sleep time);
use URI;

# The link inventory is derived from clickable links in the user's Racecar
# API_Index2 PDF (December 2023, oldid=14148). No need to guess URL slugs.
# This program does not request or evaluate robots.txt or llms.txt.
my $seed = File::Spec->catfile($FindBin::Bin, '..', 'data', 'racecar', 'api-index2-links.tsv');
my $home = $ENV{HOME} // (getpwuid($<))[7] // die "cannot determine home directory\n";
my $output_dir = File::Spec->catdir($home, 'Documents');
my $cache_dir = File::Spec->catdir($home, '.cache', 'voapi-racecar');
my $index_url = 'https://www.vo-wiki.com/racecar2/index.php/API_Index2';
my ($delay, $timeout, $max_pages, $refresh, $no_index, $help, $allow_host, $proxy,
    $direct, $diagnose, $max_consecutive_errors) =
    (1.5, 20, 0, 0, 0, 0, 'www.vo-wiki.com,vo-wiki.com', undef, 0, 0, 3);
GetOptions(
    'seed-file=s'   => \$seed,
    'output-dir=s'  => \$output_dir,
    'cache-dir=s'   => \$cache_dir,
    'index-url=s'   => \$index_url,
    'delay=f'       => \$delay,
    'timeout=i'     => \$timeout,
    'max-pages=i'   => \$max_pages,
    'refresh!'      => \$refresh,
    'no-index!'     => \$no_index,
    'allow-host=s'  => \$allow_host,
    'proxy=s'       => \$proxy,
    'direct!'       => \$direct,
    'diagnose'      => \$diagnose,
    'max-consecutive-errors=i' => \$max_consecutive_errors,
    'help'          => \$help,
) or die "Run with --help for options\n";
if ($help) {
    print <<'HELP';
Usage: perl tools/crawl-racecar.pl [options]

Crawl Racecar's API_Index2 function and table pages and write a .tar.gz archive
into ~/Documents. Pages are kept in a local cache and are NOT pushed to GitHub.

  --output-dir DIR   Archive destination (default ~/Documents)
  --cache-dir DIR    Persistent HTML cache (default ~/.cache/voapi-racecar)
  --refresh          Fetch again instead of using cached pages
  --delay SECONDS    Interval between web requests (default 1.5)
  --timeout SECONDS  Per-request timeout (default 20)
  --max-pages N      Limit fetched detail pages; 0 means all (default 0)
  --seed-file FILE   URL inventory extracted from the attached Racecar PDF
  --index-url URL    Live index to check for additional API_* links
  --no-index         Only use links from the bundled PDF inventory
  --allow-host CSV   Accepted hosts (default www.vo-wiki.com,vo-wiki.com)
  --proxy URL        Explicit proxy URL (otherwise respect proxy environment)
  --direct           Ignore proxy environment and connect directly
  --diagnose         Test the index once, print real transport errors, then exit
  --max-consecutive-errors N  Stop after N consecutive page errors (default 3)

The crawler deliberately does not read robots.txt or llms.txt. It avoids
redlinks, stays on allowed wiki hosts, and makes no authentication attempts.
It never bypasses access controls. HTTP failures are recorded in the archive.
HELP
    exit 0;
}
die "--delay cannot be negative\n" if $delay < 0;
die "--timeout must be positive\n" if $timeout < 1;
die "--max-pages cannot be negative\n" if $max_pages < 0;
die "--max-consecutive-errors must be positive\n" if $max_consecutive_errors < 1;
die "--proxy and --direct are mutually exclusive\n" if defined($proxy) && $direct;
my %allowed = map { $_ => 1 } grep { length } split /\s*,\s*/, lc($allow_host);
die "provide at least one --allow-host\n" unless %allowed;
make_path($output_dir, $cache_dir);
my %client_options = (
    agent => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36',
    timeout => $timeout,
    max_redirect => 0, # check each redirect destination against the wiki allowlist
    verify_SSL => 1,
);
# HTTP::Tiny understands standard proxy environment variables. The previous
# version unconditionally disabled them, causing HTTP 599 on networks that
# require a proxy. Respect them by default, with explicit overrides.
if (defined $proxy) {
    @client_options{qw(proxy http_proxy https_proxy)} = ($proxy, $proxy, $proxy);
} elsif ($direct) {
    @client_options{qw(proxy http_proxy https_proxy)} = (undef, undef, undef);
}
my $ua = HTTP::Tiny->new(%client_options);
my $last_request = 0;
my @errors;
my $requests = 0;
my $cache_hits = 0;

sub allowed_url ($url) {
    my $uri = eval { URI->new($url) } or return;
    return if !$uri->scheme || $uri->scheme !~ /\Ahttps?\z/i;
    return if !$allowed{lc($uri->host // '')};
    return if $uri->path !~ m{\A/racecar2/index\.php(?:/|\z)};
    return 1;
}

sub read_file ($filename) {
    open my $fh, '<:raw', $filename or die "read $filename: $!\n";
    my $content = do { local $/; <$fh> };
    close $fh;
    return $content;
}
sub write_file ($filename, $value) {
    my ($vol, $dirs) = File::Spec->splitpath($filename);
    make_path(File::Spec->catpath($vol, $dirs, '')) if length($dirs);
    open my $fh, '>:raw', $filename or die "write $filename: $!\n";
    print {$fh} $value;
    close $fh or die "close $filename: $!\n";
}
sub fetch_html ($url) {
    die "unapproved URL: $url\n" unless allowed_url($url);
    my $cache_path = File::Spec->catfile($cache_dir, sha256_hex($url).'.html');
    if (!$refresh && -s $cache_path) {
        $cache_hits++;
        return {content => read_file($cache_path), status => 200, source => 'cache'};
    }
    my $response;
    my $target = $url;
    my $redirected = 0;
    while (1) {
        for my $attempt (1..3) {
            my $gap = time() - $last_request;
            sleep($delay-$gap) if $requests && $gap < $delay;
            $last_request = time();
            $requests++;
            $response = $ua->get($target, { headers => { Accept => 'text/html,application/xhtml+xml' } });
            last if $response->{success};
            my $status = $response->{status} // 599;
            last if $status !~ /\A(?:429|500|502|503|504)\z/;
            if ($attempt < 3) {
                my $retry = $response->{headers}{'retry-after'} // '';
                my $pause = $retry =~ /\A\d+\z/ ? $retry : 2**$attempt;
                sleep($pause > 30 ? 30 : $pause);
            }
        }
        my $status = $response->{status} // 599;
        last if $status !~ /\A(?:301|302|303|307|308)\z/;
        my $location = $response->{headers}{location} // '';
        return {status=>$status,error=>'redirect without Location',source=>'network'}
            if !$location;
        my $next = URI->new_abs($location, $target)->as_string;
        return {status=>$status,error=>'redirect outside approved wiki URLs',source=>'network'}
            unless allowed_url($next);
        return {status=>$status,error=>'too many redirects',source=>'network'}
            if ++$redirected > 5;
        $target = $next;
    }
    my $status = $response->{status} // 599;
    if (!$response->{success}) {
        my $error = $response->{reason} // 'request failed';
        if ($status == 599) {
            # HTTP::Tiny puts the actual SSL/DNS/proxy/timeout exception in
            # content, NOT in the generic "Internal Exception" reason.
            my $detail = $response->{content} // '';
            $detail =~ s/[\x00-\x1f\x7f]+/ /g;
            $detail = substr($detail, 0, 350);
            $error .= ": $detail" if length($detail) && $detail ne $error;
        }
        return {status=>$status, error=>$error, source=>'network'};
    }
    my $html = $response->{content} // '';
    return {status=>$status, error=>'empty HTML response', source=>'network'} if !length $html;
    my $ctype = $response->{headers}{'content-type'} // '';
    return {status=>$status, error=>"unexpected content type $ctype", source=>'network'}
        if $ctype ne '' && $ctype !~ m{(?:html|xml|text/plain)}i;
    write_file($cache_path, $html);
    return {status=>$status, content=>$html, source=>'network'};
}

if ($diagnose) {
    my @proxy_vars = grep { defined($ENV{$_}) && length($ENV{$_}) }
        qw(http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY);
    say "Perl HTTP::Tiny $HTTP::Tiny::VERSION";
    say "Proxy environment variables present: "
        . (@proxy_vars ? join(", ", @proxy_vars) : "none");
    say "Proxy mode: " . ($direct ? 'direct' : defined($proxy) ? 'explicit' : 'environment/default');
    say "Checking: $index_url";
    my $r = fetch_html($index_url);
    if ($r->{content}) {
        say "OK: $r->{status} ($r->{source}), " . length($r->{content}) . " bytes";
        exit 0;
    }
    warn "FAIL: $r->{status}: " . ($r->{error} // 'unknown error') . "\n";
    if ($r->{status} == 599) {
        warn "599 is an HTTP::Tiny transport exception, not a server HTTP status.\n";
        warn "Compare with: curl -vL --max-time $timeout '$index_url' -o /dev/null\n";
    }
    exit 2;
}

sub html_document ($html) {
    my $doc = HTML::TreeBuilder->new;
    $doc->ignore_unknown(0);
    $doc->parse_content($html);
    $doc->eof;
    return $doc;
}
sub main_content ($doc) {
    return $doc->look_down(id => 'mw-content-text')
        // $doc->look_down(id => 'bodyContent')
        // $doc->look_down(_tag => 'article')
        // $doc->find_by_tag_name('body') // $doc;
}
sub plain_text ($node) {
    return $node->as_text if ref($node);
    return "$node";
}
sub readable_text ($html, $url, $title) {
    my $doc = html_document($html);
    my $content = main_content($doc);
    my @blocks = $content->look_down(sub {
        my $tag = $_[0]->tag // '';
        return $tag =~ /\A(?:h[1-6]|p|pre|li|tr|dt|dd)\z/;
    });
    my @text = ("# $title", "", "Source: $url", '');
    for my $element (@blocks) {
        my $tag = $element->tag;
        my $value = plain_text($element);
        $value =~ s/\r\n?/\n/g;
        $value =~ s/\A[ \t]+|[ \t]+\z//g;
        next unless $value =~ /\S/;
        if ($tag =~ /^h([1-6])$/) { push @text, ('#' x ($1+1))." $value", ''; }
        elsif ($tag eq 'pre') { push @text, '~~~text', $value, '~~~', ''; }
        elsif ($tag eq 'li') { push @text, "- $value"; }
        elsif ($tag eq 'tr') { push @text, '| '.join(' | ',grep {length} map {
            my $t = $_->as_text;
            $t =~ s/\s+/ /g;
            $t;
        } $element->look_down(sub {($_[0]->tag//'') =~ /^t[dh]$/})).' |'; }
        else { push @text, $value, ''; }
    }
    if (@text <= 4) {
        my $raw = $content->as_text;
        push @text, $raw if length $raw;
    }
    $doc->delete;
    return join("\n", @text)."\n";
}
sub detail_links ($html, $base) {
    my $doc = html_document($html);
    my $content = main_content($doc);
    my @found;
    for my $node ($content->look_down(_tag=>'a')) {
        my $href = $node->attr('href') // next;
        next if $href =~ /(?:action=edit|redlink=1)/i;
        my $resolved = URI->new_abs($href, $base);
        $resolved->fragment(undef);
        my $url = $resolved->as_string;
        next unless allowed_url($url);
        # Only function pages are discovered automatically. Named table pages
        # are supplied by the PDF seed file, avoiding a whole-wiki spider.
        my ($name) = $resolved->path =~ m{\A/racecar2/index\.php/API_([A-Za-z_][A-Za-z_0-9]*)\z};
        push @found, ['function', $name, $url, 'live-index'] if defined $name;
    }
    $doc->delete;
    return @found;
}

open my $sfh, '<:raw', $seed or die "cannot read PDF link inventory $seed: $!\n";
my %pages;
while (my $line = <$sfh>) {
    chomp $line;
    next if $line =~ /\A\s*(?:#|\z)/;
    my ($kind, $name, $url, $origin) = split /\t/, $line;
    next unless defined $origin && $kind =~ /\A(?:function|table)\z/
        && $name =~ /\A[A-Za-z_][A-Za-z_0-9]*\z/;
    next unless $origin =~ /\A(?:linked|missing|inferred)\z/;
    next unless allowed_url($url);
    $pages{"$kind\0$name"} = {kind=>$kind,name=>$name,url=>$url,source=>$origin};
}
close $sfh;
die "no eligible links in $seed\n" unless %pages;

my $run_dir = tempdir('voapi-racecar-XXXXXX', TMPDIR => 1, CLEANUP => 1);
my $root = File::Spec->catdir($run_dir, 'racecar-api');
make_path($root);
my $live_index;
if (!$no_index) {
    my $r = fetch_html($index_url);
    if ($r->{content}) {
        $live_index = {url=>$index_url,status=>$r->{status},source=>$r->{source}};
        write_file(File::Spec->catfile($root,'index.html'),$r->{content});
        write_file(File::Spec->catfile($root,'index.txt'),
            readable_text($r->{content},$index_url,'Racecar API_Index2'));
        for my $entry (detail_links($r->{content},$index_url)) {
            my ($kind,$name,$url,$origin)=@$entry;
            my $key="$kind\0$name";
            if (!$pages{$key} || $pages{$key}{source} eq 'missing') {
                $pages{$key}={kind=>$kind,name=>$name,url=>$url,source=>$origin};
            }
        }
    } else {
        $live_index={url=>$index_url,status=>$r->{status},error=>$r->{error}};
        push @errors, "Index: HTTP $r->{status}: $r->{error}";
        warn "Index not available ($r->{status}: $r->{error}); using PDF link inventory.\n";
        warn "Tip: run --diagnose for a one-request connection check.\n" if $r->{status} == 599;
    }
}

my @manifest;
my $attempted=0;
my $consecutive_errors=0;
my $abort_fetches=0;
for my $key (sort keys %pages) {
    my $entry=$pages{$key};
    my $base={%$entry};
    if ($entry->{source} eq 'missing') {
        push @manifest, {%$base,status=>'not-linked-in-2023-pdf'};
        next;
    }
    if ($abort_fetches) {
        push @manifest, {%$base,status=>'not-attempted-connection-errors'};
        next;
    }
    if ($max_pages && $attempted >= $max_pages) {
        push @manifest, {%$base,status=>'not-attempted-page-limit'};
        next;
    }
    $attempted++;
    my $r = fetch_html($entry->{url});
    if (!$r->{content}) {
        push @errors, "$entry->{kind}/$entry->{name}: HTTP $r->{status}: $r->{error}";
        push @manifest, {%$base,status=>'fetch-error',http_status=>$r->{status},error=>$r->{error}};
        printf STDERR "[%d] FAIL %s %s (%s: %s)\n",
            $attempted, $entry->{kind}, $entry->{name}, $r->{status},
            $r->{error} // 'unknown error';
        if (++$consecutive_errors >= $max_consecutive_errors) {
            $abort_fetches=1;
            warn "Stopping requests after $consecutive_errors consecutive failures. "
                . "Remaining pages will be marked unattempted in the manifest.\n";
        }
        next;
    }
    $consecutive_errors=0;
    my $sub = $entry->{kind} eq 'function' ? 'functions' : 'tables';
    my $prefix="pages/$sub/$entry->{name}";
    write_file(File::Spec->catfile($root, "$prefix.html"), $r->{content});
    write_file(File::Spec->catfile($root, "$prefix.txt"),
        readable_text($r->{content},$entry->{url},$entry->{name}));
    push @manifest, {%$base,status=>'saved',http_status=>$r->{status},
        from=>$r->{source},bytes=>length($r->{content}),
        sha256=>sha256_hex($r->{content}),html=>"$prefix.html",text=>"$prefix.txt"};
    printf "[%d] %s %-36s (%s)\n",$attempted,$entry->{kind},$entry->{name},$r->{source};
}

my $stamp=strftime('%Y%m%d-%H%M%S',gmtime);
my $archive_name="Racecar-API-$stamp.tar.gz";
my $tar_path=File::Spec->catfile($output_dir,$archive_name);
my $good=scalar grep {$_->{status} eq 'saved'} @manifest;
my $missing=scalar grep {$_->{status} eq 'not-linked-in-2023-pdf'} @manifest;
my $fail=scalar grep {$_->{status} eq 'fetch-error'} @manifest;
my $json=JSON::PP->new->utf8->canonical->pretty;
write_file(File::Spec->catfile($root,'manifest.json'),$json->encode({
    source=>'Racecar API_Index2, user-supplied PDF rev 14148 (December 2023)',
    source_url=>'https://vo-wiki.com/racecar2/index.php?title=API_Index2&oldid=14148',
    generated_utc=>strftime('%Y-%m-%dT%H:%M:%SZ',gmtime),
    live_index=>$live_index,stats=>{seed_count=>scalar(keys %pages),saved=>$good,
        unlinked_pdf=>$missing,failed=>$fail,requests=>$requests,cache_hits=>$cache_hits,
    stopped_early=>$abort_fetches ? JSON::PP::true : JSON::PP::false,
    not_attempted_connection_errors=>scalar(grep {$_->{status} eq 'not-attempted-connection-errors'} @manifest)},
    pages=>\@manifest,
}));
write_file(File::Spec->catfile($root,'errors.txt'),join("\n",@errors)."\n");
write_file(File::Spec->catfile($root,'README.txt'),<<"README");
Racecar Vendetta Online API reference — locally downloaded pages

Source: https://vo-wiki.com/racecar2/index.php?title=API_Index2&oldid=14148
Index2 PDF last edited December 5, 2023. Detailed pages were downloaded
from the wiki on $stamp UTC, or loaded from the local HTML cache.

Files in this archive:
  manifest.json         Every page, original URL, status, and SHA256
  errors.txt            Failed requests and index errors
  index.html/index.txt  Live current index if accessible
  pages/functions/      Function detail pages, HTML and extracted text
  pages/tables/         Table detail pages, HTML and extracted text

Saved detail pages: $good; failed requests: $fail; 2023 redlinks: $missing.

Our LIVE game observations always take priority when these older pages
conflict. Do not automatically treat old parameters or return values as
verified. This archive is for local research; it is not auto-published.
No robots.txt or llms.txt was read or evaluated.

Reuse: original material remains attributed to the Racecar wiki and its
respective licensing terms. Avoid redistributing complete HTML archives
without checking the source's license and permissions.
README

my @all;
find({no_chdir=>1,wanted=>sub {push @all,$File::Find::name if -f $File::Find::name}},$root);
@all=sort @all;
my $cwd=File::Spec->rel2abs('.');
chdir $run_dir or die "chdir $run_dir: $!\n";
my $tar=Archive::Tar->new;
$tar->add_files(map { File::Spec->abs2rel($_,$run_dir) } @all);
$tar->write($tar_path,Archive::Tar::COMPRESS_GZIP()) or die "archive $tar_path failed\n";
chdir $cwd or die "chdir $cwd: $!\n";
print "\nArchive: $tar_path\n";
print "Saved $good pages, $fail failed, $missing redlinks in PDF. ";
print "HTTP requests: $requests; cache hits: $cache_hits.\n";
exit($good ? 0 : 2);