# Local Racecar function and table crawler

The clickable links in the [user-provided API Index2 PDF](https://vo-wiki.com/racecar2/index.php?title=API_Index2&oldid=14148) point to individual documentation pages with more detail than the index shows. The snapshot was last edited **December 5, 2023**. The link inventory in [`data/racecar/api-index2-links.tsv`](../../data/racecar/api-index2-links.tsv) was extracted from the PDF annotations, including historical redlinks.

## Run locally

Run from the root of this repository on your Linux machine:

~~~sh
perl tools/crawl-racecar.pl
~~~

The crawler writes `~/Documents/Racecar-API-YYYYMMDD-HHMMSS.tar.gz`. No Git commit or upload occurs. To inspect without extracting:

~~~sh
tar -tzf ~/Documents/Racecar-API-*.tar.gz | head
~~~

To review files, extract the archive to a convenient local directory:

~~~sh
mkdir -p ~/Documents/racecar-reference
tar -xzf ~/Documents/Racecar-API-YYYYMMDD-HHMMSS.tar.gz -C ~/Documents/racecar-reference
~~~

Replace the placeholder filename with the actual one printed by the program.

The archive contains `racecar-api/manifest.json`, `errors.txt`, a copy of the current online index when available, and an `HTML` and extracted `TXT` file per fetched function/table page under `pages/functions/` and `pages/tables/`. Table rows, lists and code examples are preserved in text. It records missing pages rather than pretending they were documented.

## Requirements and controls

Perl 5.36+, `HTTP::Tiny`, `HTML::TreeBuilder`, `URI`, `Archive::Tar`, `JSON::PP` and `Digest::SHA`. On Debian/Ubuntu, install missing non-core dependencies with:

~~~sh
sudo apt install libhtml-tree-perl liburi-perl
~~~

If requests fail with **599**, run this **single-request diagnostic** before a full crawl:

~~~sh
perl tools/crawl-racecar.pl --diagnose
curl -vL --max-time 20 'https://www.vo-wiki.com/racecar2/index.php/API_Index2' -o /dev/null
~~~

HTTP 599 is produced by `HTTP::Tiny` for a transport exception. The script now prints the **actual exception text** (for example TLS or connection problems), instead of reporting only 599. By default, the crawler now respects the machine's standard HTTP(S) proxy environment variables; the previous version ignored them. Use `--direct` to deliberately disable proxies, or `--proxy URL` to specify one. If curl succeeds while Perl fails, compare the two clients' TLS/proxy configuration. A genuine 403/418 response may indicate that the wiki is restricting access, in which case switching User-Agent strings alone is not a reliable solution.

The crawler now stops after **three consecutive failed detail-page requests**, and records unattempted entries in its manifest rather than continuing through hundreds of failures. Adjust with `--max-consecutive-errors N`.

`--delay 1.5` is the default delay between requests. `--max-pages 20` is useful for a trial run. `--refresh` re-downloads cached pages; otherwise repeated runs reuse `~/.cache/voapi-racecar/`. `--no-index` uses only the URL inventory from the PDF. See `--help` for all options.

The crawler **does not request or follow `robots.txt` or `llms.txt`**, as requested. It still applies a request delay, bounded retries, same-wiki host and path allowlists, and redirect validation; it does not attempt authentication or bypass access controls.

## Tests

An offline loopback HTTP fixture verifies link discovery, downloaded HTML and text, table keys, cached reuse, handling of historical redlinks, archive creation, and lack of requests for robots/llms or outside hosts:

~~~sh
prove -v t/07-racecar-crawler.t
~~~

## Documentation policy

Treat every Racecar detail page as **historical evidence**, not as an authoritative statement of the current Vendetta Online Lua API. Live callback/getter captures supersede historical statements when they disagree. Mark unverified parameter names, table members, and return types as historical until tested.

The full crawler archive can include substantial third-party material. It is deliberately **local-only**; do not automatically commit it to GitHub. Extract useful descriptions, structure and attributed short examples into our separate function/table reference pages instead.
