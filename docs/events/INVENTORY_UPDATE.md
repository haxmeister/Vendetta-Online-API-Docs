# INVENTORY_UPDATE

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `1:number`.

### Recorded examples

~~~text
shape=number
event=INVENTORY_UPDATE
arguments=1
arg1 type=number value=14156
~~~

### What this tells us

A single numeric argument, `14156`, was recorded. Whether it identifies an item, ship, or other object is unconfirmed.

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
event=INVENTORY_UPDATE
arguments=1
arg1 type=number value=13304
~~~

### Interpretation

This session observed the numeric argument `13304`. Previous sessions also observed numeric arguments but did not establish their semantics.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 6. **Saved examples:** 2. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=1:number
shape=number
event=INVENTORY_UPDATE
arguments=1
arg1 type=number value=14164
~~~

~~~text
signature=1:number
shape=number
event=INVENTORY_UPDATE
arguments=1
arg1 type=number value=5866
~~~

### Interpretation and limitations

Two numeric examples (`14164`, `5866`) were captured. Some numbers also occur in ship events, but this aggregate snapshot cannot establish simultaneity or cause.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
