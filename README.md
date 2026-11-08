# Vendetta Online API Docs

A concise, community-maintained reference for the Vendetta Online Lua API.

This project is independent of Guild Software. We aim to document functions,
events, argument types, and observed behavior using evidence from the game.

The reference is still being built. Our first tool is a local **capture
collector**, which saves observations to files without copying text out of
the game UI.

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

## Licenses

Original reference documentation: CC BY 4.0.
Original software and code examples: MIT.

See [LICENSE.md](LICENSE.md) and [LICENSE-CODE](LICENSE-CODE).
