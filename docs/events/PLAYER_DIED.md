# PLAYER_DIED

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument meaning provisional.

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Saved examples:** 1. **Argument signature(s):** `4:number,number,number,number`.

### Captured examples

~~~text
signature=4:number,number,number,number
shape=number;number;number;number
event=PLAYER_DIED
arguments=4
arg1 type=number value=345929
arg2 type=number value=345929
arg3 type=number value=0
arg4 type=number value=4764
~~~

### Interpretation

Four numeric arguments were captured: `(345929, 345929, 0, 4764)`. Numeric identities and meanings are not resolved by this one sample.

**Occurrence-count caveat:** Event counters persist across flushes; do not sum these counts with previous snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.
