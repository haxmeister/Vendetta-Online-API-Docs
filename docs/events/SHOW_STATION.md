# SHOW_STATION

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

## Arguments

**Observed callback form:** `()`. Positions exclude the event name passed to `OnEvent(event, ...)`.

No positional callback arguments were observed.

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 1. **Observed argument type(s):** none.
**Captured example(s):** `()`.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 1 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `0:`.

### Recorded examples

~~~text
shape=
event=SHOW_STATION
arguments=0
~~~

### What this tells us

These are representative values from a particular game state, not constants. The precise meaning of each field may require further testing.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 2. **Saved examples:** 1. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=0:
shape=
event=SHOW_STATION
arguments=0
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:true]
context.GetCurrentStationID=1[number:1219585]
~~~

### Interpretation and limitations

The callback delivered no arguments. Context showed `PlayerInStation() = true` and a station ID of `1219585`.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. Event occurrence counters remain cumulative across flushes, and are not per-example frequencies.

~~~text
signature=0:
shape=
event=SHOW_STATION
arguments=0
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:true]
context.GetCurrentStationID=1[number:1219585]
~~~

~~~text
signature=0:
shape=
event=SHOW_STATION
arguments=0
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:true]
context.GetCurrentStationID=1[number:1299457]
~~~

No event arguments. Callback-time `PlayerInStation()` was true, with station IDs 1219585 and 1299457 in different samples.

Examples are not constants or complete schemas; callback-time getter context may reflect transitional state. [Fifth survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013130.298625Z-25441-000001.txt`, `20261109T014930.306736Z-25441-000006.txt`.
