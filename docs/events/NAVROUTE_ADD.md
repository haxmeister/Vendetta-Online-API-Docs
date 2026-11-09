# NAVROUTE_ADD

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument semantics provisional.

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 1. **Argument signature(s):** `1:number`.

### Recorded examples

~~~text
signature=1:number
shape=number
event=NAVROUTE_ADD
arguments=1
arg1 type=number value=5076
~~~

### Interpretation

The callback delivered one numeric argument with captured value `5076`; we have not independently verified whether it represents a sector, route waypoint, or other ID.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 1. Counts refer to cumulative event occurrences across flushes, not the number of times each example occurred.

~~~text
signature=1:number
shape=number
event=NAVROUTE_ADD
arguments=1
arg1 type=number value=4764
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4764]
context.GetCurrentSystemid=1[number:19]
~~~

The sole numeric argument was `4764`, matching callback-time `GetCurrentSectorid()` in this single example. Another historical example was `5076`. Whether the argument means a route entry or current sector is still unresolved.

Getter context was read during event delivery, so these correlations do not establish exact transition ordering. [Fifth context survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013130.298625Z-25441-000001.txt`.
