# CHAT_CANCELLED

**Status:** Observed in the VO client on November 8, 2026; argument signature provisional.

## Arguments

**Observed callback form:** `()`. Positions exclude the event name passed to `OnEvent(event, ...)`.

No positional callback arguments were observed.

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar says this fires when Escape is pressed in the chat-entry box.

**Historical argument information:** It states there are no callback arguments.

**Evidence priority:** The observed callback form and redaction policy in the Arguments section above take precedence over this older account.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149); last edited March 19, 2024.


---

**Occurrences:** 1 total in the initial broad-watch session.

## Observed callback arguments

1 distinct argument-type signature observed: `0:`.

The examples below show arguments received **after** the event name in `OnEvent(event, ...)`.

### Captured example

~~~text
event=CHAT_CANCELLED
arguments=0
~~~

## Interpretation and outstanding questions

The event name and argument types are known, but **argument values are intentionally redacted**, so this example does not expose chat or command content.

To collect more cases (up to 20 individual deliveries), use:

~~~text
/apidocs watch CHAT_CANCELLED
~~~

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).
- [November 8 live event survey](2026-11-08-live-event-survey.md), snapshot `20261108T223840.636743Z-24300-000001.txt`.

---

## Fourth live session — November 9, 2026 UTC

**Callbacks:** 2. **Saved examples:** 1.
**Type signature(s):** `0:`.

~~~text
event=CHAT_CANCELLED
arguments=0
~~~

Chat-related argument values, including any table fields, were deliberately **not inspected or recorded**. These examples establish callback count and types only.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).
