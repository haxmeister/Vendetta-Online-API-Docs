# CHAT_MSG_SECTORD

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); callback signature provisional.

## Arguments

**Observed callback form:** `(table)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `table` | Not identified | Redacted | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar describes a sector-daemon message, giving duel results or credit-transfer notices as examples.

**Historical argument information:** It suggests a one-field message table; our live callback delivered a table but its contents were redacted.

**Evidence priority:** Our own live callback forms and argument values, shown above, supersede these historical claims when they differ. Chat payloads remain redacted.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149); last edited March 19, 2024.


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
event=CHAT_MSG_SECTORD
arguments=1
arg1 type=table
~~~

### Interpretation

Only callback argument counts and types were retained. Chat messages, names and table values were excluded at capture time.

**Occurrence-count caveat:** The watcher retains event counters across flushes. The counts reported with these examples are cumulative at the time of capture; they cannot be added to counts from earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), captured in `20261108T234315.893757Z-24651-000062.txt`.
