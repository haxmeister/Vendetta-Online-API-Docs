# INVENTORY_REMOVE

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument semantics provisional.

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 2. **Argument signature(s):** `1:number`.

### Recorded examples

~~~text
signature=1:number
shape=number
event=INVENTORY_REMOVE
arguments=1
arg1 type=number value=9066
~~~

~~~text
signature=1:number
shape=number
event=INVENTORY_REMOVE
arguments=1
arg1 type=number value=9101
~~~

### Interpretation

The callback supplied a numeric value. Observed examples were `9066` and `9101`. Their meaning remains unverified.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 4. **Saved examples:** 2. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=1:number
shape=number
event=INVENTORY_REMOVE
arguments=1
arg1 type=number value=5867
~~~

~~~text
signature=1:number
shape=number
event=INVENTORY_REMOVE
arguments=1
arg1 type=number value=6342
~~~

### Interpretation and limitations

Two numeric examples were recorded (`5867`, `6342`). No getter context is available for this event, so these are unlabelled numeric fields.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
