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
