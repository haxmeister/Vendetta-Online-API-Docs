# UPDATE_NEWS_HEADLINES

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

**Occurrences:** 4 total in the initial broad-watch session.

## Observed callback arguments

1 distinct argument-type signature observed: `0:`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Captured example

~~~text
event=UPDATE_NEWS_HEADLINES
arguments=0
~~~

## Interpretation and outstanding questions

No additional callback arguments were observed in this session. Whether the same event can deliver arguments in other situations is untested.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch UPDATE_NEWS_HEADLINES
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

