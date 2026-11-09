# SHIP_CHANGED

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument meaning provisional.

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Saved examples:** 2. **Argument signature(s):** `1:number`.

### Captured examples

~~~text
signature=1:number
shape=number
event=SHIP_CHANGED
arguments=1
arg1 type=number value=9062
~~~

~~~text
signature=1:number
shape=number
event=SHIP_CHANGED
arguments=1
arg1 type=number value=9100
~~~

### Interpretation

The observer captured two numeric values, `9062` and `9100`. The event's numeric field may identify a ship, but that has not been independently established.

**Occurrence-count caveat:** Event counters persist across flushes; do not sum these counts with previous snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.
