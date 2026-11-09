# TRANSACTION_COMPLETED

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 1. **Observed argument type(s):** (`number`).
**Captured example(s):** `(0)`.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 1 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `1:number`.

### Recorded examples

~~~text
shape=number
event=TRANSACTION_COMPLETED
arguments=1
arg1 type=number value=0
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

**Saved examples:** 1. **Argument signature(s):** `1:number`.

### Captured examples

~~~text
signature=1:number
shape=number
event=TRANSACTION_COMPLETED
arguments=1
arg1 type=number value=6
~~~

### Interpretation

A single numeric argument, `6`, was observed, alongside the earlier sample `0`. The meaning of these values requires controlled testing.

**Occurrence-count caveat:** Event counters persist across flushes; do not sum these counts with previous snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 7. **Saved examples:** 2. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=1:number
shape=number
event=TRANSACTION_COMPLETED
arguments=1
arg1 type=number value=0
~~~

~~~text
signature=1:number
shape=number
event=TRANSACTION_COMPLETED
arguments=1
arg1 type=number value=1
~~~

### Interpretation and limitations

Examples delivered one numeric value, `0` or `1`. Earlier sessions included `6`. Their meaning has not been established through controlled purchases or other operations.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. Event occurrence counters remain cumulative across flushes, and are not per-example frequencies.

~~~text
signature=1:number
shape=number
event=TRANSACTION_COMPLETED
arguments=1
arg1 type=number value=5
~~~

~~~text
signature=1:number
shape=number
event=TRANSACTION_COMPLETED
arguments=1
arg1 type=number value=6
~~~

This callback supplied one numeric argument, 5 or 6. The code meanings are not established.

Examples are not constants or complete schemas; callback-time getter context may reflect transitional state. [Fifth survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013130.298625Z-25441-000001.txt`.
