# CHAT_MSG_CONFIRMATION

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); callback signature provisional.

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 1. **Observed callback form(s):** `1:table`.

### Recorded examples

~~~text
signature=1:table
shape=redacted
event=CHAT_MSG_CONFIRMATION
arguments=1
arg1 type=table
~~~

### Interpretation

Only callback argument counts and types were retained. Chat messages, names and table values were excluded at capture time.

**Occurrence-count caveat:** The watcher retains event counters across flushes. The counts reported with these examples are cumulative at the time of capture; they cannot be added to counts from earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), captured in `20261109T000121.364994Z-24651-000114.txt`.
