# DESIRED_SPEED_CHANGED

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

**Occurrences:** 120 total in the initial broad-watch session.

## Observed callback arguments

1 distinct argument-type signature observed: `0:`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Captured example

~~~text
event=DESIRED_SPEED_CHANGED
arguments=0
~~~

## Interpretation and outstanding questions

No additional callback arguments were observed in this session. Whether the same event can deliver arguments in other situations is untested.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch DESIRED_SPEED_CHANGED
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 1. **Argument signature(s):** `0:`.

### Recorded examples

~~~text
signature=0:
shape=
event=DESIRED_SPEED_CHANGED
arguments=0
~~~

### Interpretation

These observations demonstrate example types and values, not guaranteed event-field semantics.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261108T234315.893757Z-24651-000062.txt`.
