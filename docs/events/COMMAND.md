# COMMAND

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

**Occurrences:** 4 total in the initial broad-watch session.

## Observed callback arguments

2 distinct argument-type signatures observed: `1:number` or `2:number,table`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Signature 1

~~~text
event=COMMAND
arguments=1
arg1 type=number
~~~

### Signature 2

~~~text
event=COMMAND
arguments=2
arg1 type=number
arg2 type=table
~~~

## Interpretation and outstanding questions

The event name and argument types are known, but **argument values are intentionally redacted**, so this example does not expose chat or command content.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch COMMAND
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

