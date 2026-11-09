# MISSIONLIST_UPDATED

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 12. **Observed argument type(s):** (`nil`).
**Captured example(s):** `(nil)` — one actual nil argument.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 28 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `1:nil`.

### Recorded examples

~~~text
shape=nil
event=MISSIONLIST_UPDATED
arguments=1
arg1 type=nil value=nil
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

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 1. **Argument signature(s):** `1:number`.

### Recorded examples

~~~text
signature=1:number
shape=number
event=MISSIONLIST_UPDATED
arguments=1
arg1 type=number value=3
~~~

### Interpretation

**New argument type:** A single numeric argument, `3`, was observed. Earlier captures returned one explicit `nil` argument. Both `nil` and `number` are now confirmed observed types; do not describe this event as always delivering `nil`.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 27. **Saved examples:** 2. These are event-wide counts, not frequencies of each sample.

### Observed argument examples and getter context

~~~text
signature=1:nil
shape=nil
event=MISSIONLIST_UPDATED
arguments=1
arg1 type=nil value=nil
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:false]
context.GetCurrentStationID=1[nil]
~~~

~~~text
signature=1:nil
shape=nil
event=MISSIONLIST_UPDATED
arguments=1
arg1 type=nil value=nil
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:true]
context.GetCurrentStationID=1[number:1299457]
~~~

### Evidence and interpretation

Both saved callbacks delivered **one explicit nil argument**. The same nil form was seen when `PlayerInStation()` was `false` with station ID nil, and `true` with a numeric station ID. A previous batch independently observed `(3)`; this event can deliver nil or a number.

**Limitations:** Getter context was obtained inside the event callback; it does not establish pre-event state or callback ordering.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
