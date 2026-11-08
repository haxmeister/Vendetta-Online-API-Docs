# Vendetta Online API Docs

A concise, community-maintained reference for the Vendetta Online Lua API.

This project is independent of Guild Software. We aim to document functions,
events, argument types, and observed behavior using evidence from the game.

The reference is still being built. Start with our
[12 observed getter signatures](docs/functions/observed-getters.md), the
[398-name function survey](docs/research/2026-11-08-full-function-survey.md),
the [event reference (214 individual pages)](docs/events/index.md),
and the [first 65-capture review](docs/research/2026-11-08-observation-review.md).

All reference entries should show **actual observed example values**, not just
types. See the [documentation conventions](docs/reference-conventions.md)
for how we distinguish function returns from event callback arguments.

Our first tool is a local **capture collector**, which saves observations to
files without copying text out of the game UI.

## Run the collector

Requires Linux, Perl 5.36+, and [Linux::Event](https://metacpan.org/pod/Linux::Event)
with its native DecimalLength framer.

From the repository root:

~~~sh
perl tools/collect.pl
~~~

It listens only on **127.0.0.1:54000**. Captures go into the local
**captures/** directory (ignored by Git).

Choose a different port or output directory if needed:

~~~sh
perl tools/collect.pl --port 54001 --out /path/to/captures
~~~

In another terminal, send sample observations and inspect the files:

~~~sh
perl tools/send-test.pl
find captures -type f
prove -lr t
~~~

The sender does not require Linux::Event. The tests exercise file storage
and validation without starting a game client.

## Sending from Vendetta Online

The existing [TCP plugin](https://github.com/haxmeister/TCP) is the intended
transport. There is no need to modify TCP or copy its code into this repo.

The wire format is:

~~~text
<byte-length>:<category>\0<name>\0<body>
~~~

The \0 symbols above represent actual NUL bytes, not literal backslash
characters. The decimal length counts **bytes in the payload**, not the prefix.
There is **no trailing newline** or other terminator.

For example, a Lua plugin can send:

~~~lua
local TCP = dofile("../TCP/client.lua")

local conn = TCP.Connect("127.0.0.1", 54000, {
    onError = function(reason)
        print("API collector error: " .. tostring(reason))
    end
})

local function capture(category, name, body)
    if not conn then
        return nil, "not connected"
    end
    local payload = category .. "\0" .. name .. "\0" .. body
    return conn:Send(tostring(#payload) .. ":" .. payload)
end

capture("event", "SECTOR_LOADED", "First line\nSecond line")
~~~

Use **conn:Send()**, not **conn:SendMessage()**: the framing is part of
this collector's protocol.

TCP can split or combine writes. Linux::Event's native DecimalLength framer
reconstructs records even when the text contains newlines, colons, or NUL bytes.

Accepted categories: **event**, **function**, **snapshot**, **note**.
Names must start with a letter or underscore and contain only letters, digits,
underscores, dots, and hyphens. Records are limited to 262,144 bytes.

## Saved observations

Each message becomes a separate raw text file:

~~~text
captures/
├── event/
│   └── SECTOR_LOADED/
│       └── 20261108T200000.123456Z-1234-000001.txt
├── function/
│   └── GetPlayerName/
└── snapshot/
    └── globals/
~~~

The server does not rewrite the text, infer function signatures, or
automatically publish observations as verified documentation. The category,
name, and capture timestamp come from the directory and filename.

Captured data can contain player information or chat. Review files before
publishing or sharing them.

## Share observations without uploading files

After collecting observations, generate a complete, readable report:

~~~sh
perl tools/share-observations.pl
~~~

This creates a **temporary handoff** at `docs/research/capture-summary.md`.
It includes available recorded values and errors, non-chat event observations,
snapshots, and notes. The generator skips captures at or before the last
reviewed timestamp in `data/reviewed-through.txt`; use `--all` if you
specifically need to re-export earlier captures. Old inspection captures
contain only string lengths where the game never recorded the text.

**Chat payloads are the exception:** `CHAT_*`, `ACTIVATE_CHAT_*`,
`COMMAND` and `EMOTE_ENTERED` retain only event names, argument counts,
and types. Their values are redacted both by the latest APIProbe and by
the report generator. The local `captures/` files remain intact and
Git-ignored.

To publish the updated report for ChatGPT to read:

~~~sh
perl tools/share-observations.pl --push
~~~

The script **asks before committing and pushing** to your *public* GitHub
repository. Read `docs/research/capture-summary.md` first. Other events,
notes and function observations can still contain names, positions or
private information that the chat-event filter cannot detect. A push may
also publish other commits that are pending locally. Nothing is uploaded
automatically from the game.

Once pushed, ask ChatGPT to review the report. After the observations have
been incorporated into the permanent function/event reference, **delete the
temporary report from the current Git tree** and advance
`data/reviewed-through.txt`. This keeps the working repository lean.
Deleting a Git file does not erase its earlier versions from Git history.
For private diagnostics, upload a single TAR file instead of publishing.

A `--push` attempts `git pull --rebase` before pushing, but unrelated local
changes or conflicts may still require manual Git reconciliation.

## APIProbe (in-game discovery)

The first discovery plugin is in [plugin/APIProbe](plugin/APIProbe).
It uses the already-installed [TCP plugin](https://github.com/haxmeister/TCP);
it does not include a second copy of TCP.

Copy the **APIProbe** directory into your Vendetta Online plugins folder:

~~~text
plugins/
├── TCP/
│   └── client.lua
└── APIProbe/
    ├── main.lua
    ├── candidates.lua
    ├── inspections.lua
    └── events.lua
~~~

**Linux symlink installation:** VO resolves sibling paths such as
`../TCP/client.lua` relative to `plugins/APIProbe/`. Do **not** symlink the
entire `APIProbe` directory into another repository: the parent path may
no longer point to `plugins/TCP/`. Instead, create a real `plugins/APIProbe/`
directory and symlink its Lua files individually:

~~~sh
SOURCE=/home/haxmeister/Documents/lua/Vendetta-Online-API-Docs/plugin/APIProbe
PLUGINS="$HOME/.vendetta/plugins"  # adjust to your VO installation

# Only for a currently symlinked APIProbe directory:
[ -L "$PLUGINS/APIProbe" ] && unlink "$PLUGINS/APIProbe"
mkdir -p "$PLUGINS/APIProbe"
for file in main.lua candidates.lua inspections.lua events.lua; do
    ln -sfn "$SOURCE/$file" "$PLUGINS/APIProbe/$file"
done
~~~

This leaves the sibling `plugins/TCP/` location intact while allowing
updates from `git pull` to appear immediately on the next interface reload.

Start the Perl collector first, then launch VO (or reload the interface).
Nothing is sent automatically. Use these commands in the VO chat console:

| Command | Purpose |
| --- | --- |
| /apidocs connect | Connect to the local collector |
| /apidocs test | Send a two-line test observation |
| /apidocs scan | Check the generated candidate list and record types or accessibility |
| /apidocs inspect list | Show the approved read-only getters |
| /apidocs inspect GetCurrentSectorid | Call one approved getter and record return types |
| /apidocs inspect all | Inspect all 12 approved getters once |
| /apidocs watch SECTOR_LOADED | Observe up to 20 occurrences of one event |
| /apidocs watch all | Watch 214 historical event names with bounded aggregation |
| /apidocs flush | Save new broad-watch event signatures as a few snapshots |
| /apidocs unwatch all | Flush and unregister broad watches |
| /apidocs unwatch SECTOR_LOADED | Stop watching one event |
| /apidocs status | Report connection and watch count |
| /apidocs stop | Unregister all watches and disconnect |

**First live test:** Run /apidocs connect, wait for the connected message,
then run /apidocs test. Look for a new file under
captures/note/connection_test/ on the Perl side. Next, run /apidocs scan
and inspect captures/snapshot/functions/.

The game's strict Lua environment does not expose `_G` or `getfenv`.
Consequently, `scan` is **not** an exhaustive global inventory. Instead,
`candidates.lua` contains generated protected reads for known names from API
references and plugin examples. A read reports a Lua type (`function`,
`table`, etc.) or `inaccessible`. This does not establish that a function
exists or that a name belongs to the built-in API. It never calls candidates.

The snapshot appears under `captures/snapshot/functions/` and identifies
itself with `format=api-probe-v1` and `source=generated-candidates`.
Larger scans split into numbered parts (150 candidates per part). The current
list contains **398 names**: 390 distinct names extracted from a historical
Racecar2 Function Index, combined with our existing candidates. The imported
index was last edited in December 2023, so results require current verification.

### Expand function candidates

Edit `data/function-candidates.txt` to add new global names (one per line),
then regenerate the Lua probe file:

~~~sh
perl tools/build-probes.pl
texlua t/mock-plugin.lua
~~~

To import a new Racecar2 Function Index, save its page as plain text or HTML,
then run:

~~~sh
perl tools/import-candidates.pl /path/to/saved-Function-Index.txt
perl tools/build-probes.pl
~~~

The importer recognizes the `Functions` section of plain-text copies and
`API_FunctionName` links in HTML copies. It collects **candidate names only**;
it does not import third-party descriptions or arguments. Names that no longer
exist remain marked `inaccessible` until independently verified.

After pulling the current repository, you do **not** need to import the index
again: the 398-name candidate list and generated probe are already committed.

After regenerating `candidates.lua`, copy both `main.lua` and
`candidates.lua` to your installed `plugins/APIProbe/` directory, reload
the interface, connect, and run `/apidocs scan` again.

### Inspect read-only getters

After completing the function-name scan, use the separate, manually reviewed
`inspections.lua` allowlist to collect return-value observations:

~~~text
/apidocs connect
/apidocs inspect list
/apidocs inspect GetCurrentSectorid
/apidocs inspect all
~~~

**Inspection is opt-in.** No functions run on plugin load or during
`/apidocs scan`. Only the 12 getter closures declared in `inspections.lua`
may be invoked, and only by `/apidocs inspect NAME` or `inspect all`.
Unknown names are rejected. This is not a generic function executor.

Each call creates a file in `captures/function/<Name>/`. The capture
includes its success/error status, exact number of returned values, types
(including nil), numerical/boolean scalar values, and string contents
(up to 1024 bytes per string, with the full byte length recorded).
Table fields and userdata are not inspected.
Errors are caught with `pcall` and included as bounded, quoted messages.
The collector and its wire protocol are unchanged.

Functions may return different results when docked, in flight, or targeting
another ship. For a useful first sample, run `inspect all` while docked;
afterward you can inspect selected getters again in space. An error is
itself an observation, not proof the function is broken.

See [function-inspector.md](docs/research/function-inspector.md) for the
whitelist and output format. Copy **all three** APIProbe Lua files when
updating the installed plugin.

There is [one page per known event](docs/events/index.md), including captured
example arguments, observed table previews, and clear unverified placeholders.
The original multi-event survey is retained for comparison.

Event observation is opt-in. You can watch one event in detail or use
`/apidocs watch all` to register 214 unique historical names at once.
Broad watching automatically captures different argument types, changing
table shapes, and up to two distinct values per shape (six shapes per event,
512 total examples per session). `/apidocs flush` or `/apidocs stop` sends
the buffered examples as bounded snapshots. **You do not need to watch each
event individually to capture its table fields.**
This is not a runtime discovery of undocumented event names; see
[the broad event watcher](docs/events/broad-watch.md).
For strings, it records quoted Lua text (with newline escapes), byte lengths,
and argument types. Tables receive bounded nested field/value previews. Large
events are truncated, and each event watch is limited to 20 observations.

Observations may include sensitive player information if you watch chat or
other player-facing events. Captures stay local and are not committed to Git.

A local Lua mock test is available:

~~~sh
texlua t/mock-plugin.lua
~~~

## Licenses

Original reference documentation: CC BY 4.0.
Original software and code examples: MIT.

See [LICENSE.md](LICENSE.md) and [LICENSE-CODE](LICENSE-CODE).
