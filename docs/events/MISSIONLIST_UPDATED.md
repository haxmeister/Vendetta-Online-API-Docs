# MISSIONLIST_UPDATED

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

**Occurrences:** 12 total in the initial broad-watch session.

## Observed callback arguments

1 distinct argument-type signature observed: `1:nil`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Captured example

~~~text
event=MISSIONLIST_UPDATED
arguments=1
arg1 type=nil value=nil
~~~

## Interpretation and outstanding questions

The snapshot explicitly records a `nil` argument. This differs from receiving no additional arguments.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch MISSIONLIST_UPDATED
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

