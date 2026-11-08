# NAVROUTE_CHANGED

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 2. **Observed argument type(s):** (`table`).
**Captured example(s):** one table argument; shallow preview `{"1": number}`.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `1:table`.

### Recorded examples

~~~text
shape=table{1:number}
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{[1]=4763}
~~~

~~~text
shape=table{}
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{}
~~~

### What this tells us

Two table shapes were captured: a route with numeric key `[1]` holding `4763`, and an empty table. The key likely represents an indexed route entry, but its exact meaning has not been verified.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.
