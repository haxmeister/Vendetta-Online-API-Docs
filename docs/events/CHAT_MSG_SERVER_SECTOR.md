# CHAT_MSG_SERVER_SECTOR

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

**Occurrences:** 4 total in the initial broad-watch session.

## Observed callback arguments

1 distinct argument-type signature observed: `1:table`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Captured example

~~~text
event=CHAT_MSG_SERVER_SECTOR
arguments=1
arg1 type=table
~~~

## Interpretation and outstanding questions

The event name and argument types are known, but **argument values are intentionally redacted**, so this example does not expose chat or command content.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch CHAT_MSG_SERVER_SECTOR
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

