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

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 4. **Saved examples:** 2. These are event-wide counts, not frequencies of each sample.

### Observed argument examples and getter context

~~~text
signature=1:number
shape=number
event=SHIP_CHANGED
arguments=1
arg1 type=number value=14164
context=callback-time-approved-getters-v1
context.GetActiveShipName=1[nil]
context.HasActiveShip=1[boolean:false]
context.GetActiveShipHealth=0[]
~~~

~~~text
signature=1:number
shape=number
event=SHIP_CHANGED
arguments=1
arg1 type=number value=5866
context=callback-time-approved-getters-v1
context.GetActiveShipName=1[string]
context.HasActiveShip=1[boolean:true]
context.GetActiveShipHealth=10[number:0,number:0,number:0,number:0,number:0,number:0,number:0,number:6000,nil,nil]
~~~

### Evidence and interpretation

One callback delivered numeric `14164` while `HasActiveShip()` was false, `GetActiveShipName()` returned one nil, and `GetActiveShipHealth()` returned **zero values**. Another delivered `5866` while an active ship was present and health returned ten positions. These likely reflect distinct phases of a ship transition, but meanings are not yet proven.

**Limitations:** Getter context was obtained inside the event callback; it does not establish pre-event state or callback ordering.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
