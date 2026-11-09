# SHIP_UPDATED

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `1:number`.

### Recorded examples

~~~text
shape=number
event=SHIP_UPDATED
arguments=1
arg1 type=number value=14156
~~~

### What this tells us

A numeric argument `14156` was observed, also seen in the `INVENTORY_UPDATE` sample. That shared value is suggestive, but it does not establish a semantic relationship.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Saved examples:** 1. **Argument signature(s):** `1:number`.

### Captured examples

~~~text
signature=1:number
shape=number
event=SHIP_UPDATED
arguments=1
arg1 type=number value=9062
~~~

### Interpretation

A numeric value of `9062` was captured. It also appears in one `SHIP_CHANGED` sample, but simultaneity and causal relationship cannot be established from this aggregate report.

**Occurrence-count caveat:** Event counters persist across flushes; do not sum these counts with previous snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 5. **Saved examples:** 2. These are event-wide counts, not frequencies of each sample.

### Observed argument examples and getter context

~~~text
signature=1:number
shape=number
event=SHIP_UPDATED
arguments=1
arg1 type=number value=14168
context=callback-time-approved-getters-v1
context.GetActiveShipName=1[string]
context.HasActiveShip=1[boolean:true]
~~~

~~~text
signature=1:number
shape=number
event=SHIP_UPDATED
arguments=1
arg1 type=number value=5866
context=callback-time-approved-getters-v1
context.GetActiveShipName=1[string]
context.HasActiveShip=1[boolean:true]
~~~

### Evidence and interpretation

The event delivered one number (`14168` or `5866`). Both contextual samples showed an active ship and a string ship name (the string content was intentionally omitted), supporting a relation to ship state but not the precise identity of the numeric argument.

**Limitations:** Getter context was obtained inside the event callback; it does not establish pre-event state or callback ordering.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. Event occurrence counters remain cumulative across flushes, and are not per-example frequencies.

~~~text
signature=1:number
shape=number
event=SHIP_UPDATED
arguments=1
arg1 type=number value=11824
context=callback-time-approved-getters-v1
context.GetActiveShipName=1[string]
context.HasActiveShip=1[boolean:true]
~~~

~~~text
signature=1:number
shape=number
event=SHIP_UPDATED
arguments=1
arg1 type=number value=14164
context=callback-time-approved-getters-v1
context.GetActiveShipName=1[string]
context.HasActiveShip=1[boolean:true]
~~~

The callback had one numeric argument, 11824 or 14164. In both examples an active ship existed and the ship-name getter returned a string type; numeric argument semantics remain unknown.

Examples are not constants or complete schemas; callback-time getter context may reflect transitional state. [Fifth survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013130.298625Z-25441-000001.txt`.
