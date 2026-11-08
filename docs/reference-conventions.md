# How we document observed API behavior

A usable reference entry should answer **what does it return or deliver?**, **what might the values look like?**, and **in what state was it observed?**

## Functions

Record these fields whenever evidence allows:

- **Name and invocation**: e.g. `GetCurrentSectorid()`.
- **Return count and types**: distinguish one `nil` from zero returned values, and preserve multiple return positions.
- **Example result from a live capture**: e.g. `5597`, or `(167.31474304199, 0.66925895214081)`. Multiple values in parentheses are **not** a Lua table.
- **Context**: docked/undocked, whether a target existed, target category, etc., only when established by evidence.
- **Interpretation**: name fields only when supported; label likely meanings *tentative*.
- **Evidence and limitations**: link the reviewed capture batch or source and state which cases are untested.

Example:

~~~text
GetCurrentStationID()
Observed returns: number or nil
Example (docked): 1432833
Example (undocked): nil
Notes: One docked and four undocked observations; IDs change by station.
~~~

## Events

Each event has its own page in the [event reference](events/index.md). The combined survey is an index of observations, not a replacement for per-event documentation.


Events **deliver callback arguments**; these are not values returned by the event handler. Our observer uses `OnEvent(event_name, ...)`, so examples show the arguments **after** the event-name argument.

Example:

~~~text
SECTOR_CHANGED
Observed callback arguments: (number sectorid)
Example: (5570)
Seen: four times in the first broad-watch session
~~~

Write `()` for **zero callback arguments** and `(nil)` for **one explicit nil argument**.

For an event with more than one observed type signature, show **each**:

~~~text
CINEMATIC_START
Observed argument types: (boolean) or (number)
Examples: (false) or (4)
Meaning of the value: not yet established
~~~

Do not invent examples to fill gaps. For chat events, retain the argument types but omit recorded message contents, speaker names, and any other chat payload values. For table arguments, do not invent a table structure when our collector only recorded a shallow type preview.

## Review and retention

The collector keeps raw files locally. A temporary GitHub report can be shared for review; after extracting evidence into these permanent references, advance `data/reviewed-through.txt` and remove the temporary report from the current branch. Prior commits retain historical versions.

Prior observation does **not** imply an API is guaranteed to behave identically across all clients, ships, game states, or future versions.
