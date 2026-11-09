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

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 1. **Saved examples:** 1. Each `occurrences` total applies to the event, not to each example.

### Observed arguments and game state

~~~text
signature=4:number,number,number,number
shape=number;number;number;number
event=PLAYER_DIED
arguments=4
arg1 type=number value=345929
arg2 type=number value=345929
arg3 type=number value=0
arg4 type=number value=4764
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4764]
context.PlayerInStation=1[boolean:false]
context.HasActiveShip=1[boolean:false]
~~~

### Evidence and interpretation

In this single sample the event's **fourth number**, `4764`, equaled callback-time `GetCurrentSectorid()`. `PlayerInStation()` and `HasActiveShip()` were both `false`. This supports a tentative sector-ID interpretation of position 4, not proof.

**Limitations:** Getter context was read during the callback, not necessarily before the event transition. A matching number is correlation evidence, not universal field semantics.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
