# MSG_LOGOFF_TIMER

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument semantics provisional.

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
