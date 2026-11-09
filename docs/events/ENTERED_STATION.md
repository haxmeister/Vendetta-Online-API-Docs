# ENTERED_STATION

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

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
event=ENTERED_STATION
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

**Callbacks in this session:** 2. **Saved examples:** 1. Each `occurrences` total applies to the event, not to each example.

### Observed arguments and game state

~~~text
signature=0:
shape=
event=ENTERED_STATION
arguments=0
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:true]
context.GetCurrentStationID=1[number:1219585]
context.GetCurrentSectorid=1[number:4764]
~~~

### Evidence and interpretation

No callback arguments. At the sampled callback, `PlayerInStation() = true`, station ID `1219585`, and sector ID `4764`.

**Limitations:** Getter context was read during the callback, not necessarily before the event transition. A matching number is correlation evidence, not universal field semantics.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
