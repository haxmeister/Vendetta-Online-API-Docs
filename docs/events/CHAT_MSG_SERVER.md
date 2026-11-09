# CHAT_MSG_SERVER

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); callback signature provisional.

## Arguments

**Observed callback form:** `(table)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `table` | Not identified | Redacted | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 1. **Observed callback form(s):** `1:table`.

### Recorded examples

~~~text
signature=1:table
shape=redacted
event=CHAT_MSG_SERVER
arguments=1
arg1 type=table
~~~

### Interpretation

Only callback argument counts and types were retained. Chat messages, names and table values were excluded at capture time.

**Occurrence-count caveat:** The watcher retains event counters across flushes. The counts reported with these examples are cumulative at the time of capture; they cannot be added to counts from earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), captured in `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — November 9, 2026 UTC

**Callbacks:** 12. **Saved examples:** 1.
**Type signature(s):** `1:table`.

~~~text
event=CHAT_MSG_SERVER
arguments=1
arg1 type=table
~~~

Chat/command argument values and table fields were **not captured**. The type-only record does not reveal message contents or command data.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).
