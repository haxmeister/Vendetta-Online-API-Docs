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

Each event has its own page in the [event reference](events/index.md).
For questions about what an event argument *means*, gather callback-time
context using the [bounded read-only correlation mode](events/context-correlation.md).
A matching numeric getter result is evidence of correlation, **not proof**
of field semantics; document repeated matches and counterexamples. The combined survey is an index of observations, not a replacement for per-event documentation.


Events **deliver callback arguments**; these are not values returned by the event handler. Our observer uses `OnEvent(event_name, ...)`, so examples show the arguments **after** the event-name argument.

Each event page begins with an **Arguments** section. A captured event shows its observed callback form(s), followed by a table with **position**, **Lua type**, **meaning**, **real example**, and **confidence in the meaning**. The section is a quick reference; dated evidence and limitations remain below it. An unobserved event states that the count, types, and meanings are unknown. Never invent a zero-argument signature merely because no arguments have yet been captured.

Use these confidence labels for the **meaning**, not for the independently observed Lua type:

- **High**: direct content (such as a notification message or zone marker) or repeated matches to independent getters in several states.
- **Strong (provisional)**: repeated independent correlations support the meaning but counterexamples or a more controlled test are still needed.
- **Tentative**: a plausible interpretation supported by limited evidence.
- **Unknown**: the type/value was captured, but what the argument represents is not established.

A row with **Unknown** confidence is useful: it still documents the captured position, type, and actual values without naming unverified fields. For mixed signatures (e.g. zero-or-one argument), retain each observed form. For privacy-redacted chat events, show argument types but no private values or table keys.



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

Do not invent examples to fill gaps. For chat events, retain the argument types but omit recorded message contents, speaker names, and any other chat payload values. For table arguments, do not invent a table structure when earlier captures recorded only a shallow type preview. APIProbe's broad watcher now collects bounded nested field values and multiple examples when values or shapes differ. Distinguish newer `api-event-watch-v2` and context-enabled `api-event-watch-v3` examples from historical type-only previews, record truncation limits, and never infer a missing field was absent outside the captured sample.

## Review and retention

The collector keeps raw files locally. A temporary GitHub report can be shared for review; after extracting evidence into these permanent references, advance `data/reviewed-through.txt` and remove the temporary report from the current branch. Prior commits retain historical versions.

Prior observation does **not** imply an API is guaranteed to behave identically across all clients, ships, game states, or future versions.
