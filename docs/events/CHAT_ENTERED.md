# CHAT_ENTERED

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

## Arguments

**Observed callback form:** `(string)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `string` | Not identified | Redacted | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar says this occurs after `CHAT_DONE` and echoes the typed chat-bar text.

**Historical argument information:** It labels its callback value as the entered text; our one-string callback is compatible, but its contents are deliberately redacted.

**Evidence priority:** The observed callback form and redaction policy in the Arguments section above take precedence over this older account.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149); last edited March 19, 2024.


---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 5 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `1:string`.

### Recorded examples

~~~text
shape=redacted
event=CHAT_ENTERED
arguments=1
arg1 type=string
~~~

### What this tells us

Only argument types were collected. Chat and command contents, including table values, were omitted before capture.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## Fourth live session — November 9, 2026 UTC

**Callbacks:** 1. **Saved examples:** 1.
**Type signature(s):** `1:string`.

~~~text
event=CHAT_ENTERED
arguments=1
arg1 type=string
~~~

Chat-related argument values, including any table fields, were deliberately **not inspected or recorded**. These examples establish callback count and types only.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).
