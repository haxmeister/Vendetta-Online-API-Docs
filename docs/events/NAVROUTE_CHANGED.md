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

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Saved examples:** 1. **Argument signature(s):** `1:table`.

### Captured examples

~~~text
signature=1:table
shape=table{1:number}
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{[1]=4764}
~~~

### Interpretation

The numeric route-table value in this new sample is `4764`, compared with `[1]=4763` and an empty table in earlier captures. It is a changing value in an indexed table; its exact semantic meaning remains provisional.

**Occurrence-count caveat:** Event counters persist across flushes; do not sum these counts with previous snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261108T234315.893757Z-24651-000062.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 2. **Saved examples:** 2. These are event-wide counts, not frequencies of each sample.

### Observed argument examples and getter context

~~~text
signature=1:table
shape=table{1:number}
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{[1]=4764}
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:5076]
context.GetCurrentSystemid=1[number:20]
~~~

~~~text
signature=1:table
shape=table{}
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{}
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4764]
context.GetCurrentSystemid=1[number:19]
~~~

### Evidence and interpretation

The populated route table carried `[1]=4764`, while the callback-time `GetCurrentSectorid()` was `5076` (system `20`). Thus this route value **does not always equal the current sector ID**. A second empty table was observed with current sector `4764` (system `19`).

**Limitations:** Getter context was obtained inside the event callback; it does not establish pre-event state or callback ordering.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
