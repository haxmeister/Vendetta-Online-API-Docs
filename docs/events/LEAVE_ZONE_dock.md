# LEAVE_ZONE_dock

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

**Occurrences:** 1 total in the initial broad-watch session.

## Observed callback arguments

1 distinct argument-type signature observed: `1:string`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Captured example

~~~text
event=LEAVE_ZONE_dock
arguments=1
arg1 type=string value="dock" (bytes=4)
~~~

## Interpretation and outstanding questions

The values above are **examples**, not constants. The exact semantic meaning of each argument remains unverified unless established in a separate controlled test.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch LEAVE_ZONE_dock
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

