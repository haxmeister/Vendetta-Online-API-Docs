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
