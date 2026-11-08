# NAVROUTE_CHANGED

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

**Occurrences:** 2 total in the initial broad-watch session.

## Observed callback arguments

1 distinct argument-type signature observed: `1:table`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Captured example

~~~text
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{"1":number}
~~~

## Interpretation and outstanding questions

A table was delivered as an argument, but the initial watcher recorded only a **shallow preview of field names and value types**. Actual field values and nested table structure have not yet been established. A later focused capture with the enhanced table inspector can populate this section.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch NAVROUTE_CHANGED
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

