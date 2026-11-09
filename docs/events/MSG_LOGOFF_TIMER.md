# MSG_LOGOFF_TIMER

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument semantics provisional.

## Arguments

**Observed callback form:** `(string)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `string` | Countdown/status text | `"10 seconds to self-destruct."`, `"9 seconds to self-destruct."` | High |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 2. **Argument signature(s):** `1:string`.

### Recorded examples

~~~text
signature=1:string
shape=string
event=MSG_LOGOFF_TIMER
arguments=1
arg1 type=string value="10 seconds to self-destruct." (bytes=28)
~~~

~~~text
signature=1:string
shape=string
event=MSG_LOGOFF_TIMER
arguments=1
arg1 type=string value="9 seconds to self-destruct." (bytes=27)
~~~

### Interpretation

A single string argument was observed. Two captured examples were countdown messages (`10 seconds` and `9 seconds` to self-destruct). These are example text values, not proof of a particular timer cadence.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — November 9, 2026 UTC

**Callbacks:** 11. **Saved examples:** 2.
**Type signature(s):** `1:string`.

~~~text
event=MSG_LOGOFF_TIMER
arguments=1
arg1 type=string value="10 seconds to self-destruct." (bytes=28)
~~~

~~~text
event=MSG_LOGOFF_TIMER
arguments=1
arg1 type=string value="9 seconds to self-destruct." (bytes=27)
~~~

### Interpretation

The sampled strings were countdown messages (`10 seconds` and `9 seconds` to self-destruct). The callback interval was not captured.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. Event occurrence counters remain cumulative across flushes, and are not per-example frequencies.

~~~text
signature=1:string
shape=string
event=MSG_LOGOFF_TIMER
arguments=1
arg1 type=string value="10 seconds to self-destruct." (bytes=28)
~~~

~~~text
signature=1:string
shape=string
event=MSG_LOGOFF_TIMER
arguments=1
arg1 type=string value="9 seconds to self-destruct." (bytes=27)
~~~

Captured actual string values `"10 seconds to self-destruct."` and `"9 seconds to self-destruct."`; this does not establish callback cadence.

Examples are not constants or complete schemas; callback-time getter context may reflect transitional state. [Fifth survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013730.312126Z-25441-000003.txt`.
