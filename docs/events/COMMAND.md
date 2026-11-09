# COMMAND

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

## Arguments

**Observed callback forms:** `(number, table)` or `(number)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `number` | Not identified | Redacted | Unknown |
| 2 | `table` | Not identified | Redacted | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar says this event fires when a slash command is executed, using `/echo` as an example.

**Historical argument descriptions:** It calls position 1 `command_id` (integer command code) and describes position 2 as a list of string command arguments, with an absent/nil case.

**Live evidence:** We observed `(number)` and `(number, table)` forms. Command data and table values were deliberately redacted. Historical field names are plausible but not verified; do not claim the second argument is always provided or has a known internal schema.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149), last edited March 19, 2024. These claims are not live verification.


---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 4. **Observed argument type(s):** (`number`) **or** (`number`, `table`).
**Captured example(s):** `(number)` or `(number, table)`; values redacted.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 29 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `1:number` or `2:number,table`.

### Recorded examples

~~~text
shape=redacted
event=COMMAND
arguments=1
arg1 type=number
~~~

~~~text
shape=redacted
event=COMMAND
arguments=2
arg1 type=number
arg2 type=table
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

**Callbacks:** 10. **Saved examples:** 2.
**Type signature(s):** `1:number` or `2:number,table`.

~~~text
event=COMMAND
arguments=1
arg1 type=number
~~~

~~~text
event=COMMAND
arguments=2
arg1 type=number
arg2 type=table
~~~

Chat/command argument values and table fields were **not captured**. The type-only record does not reveal message contents or command data.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).
