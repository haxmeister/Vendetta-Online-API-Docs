# CHAT_MSG_CHANNEL_ACTIVE

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

## Arguments

**Observed callback form:** `(table)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `table` | Not identified | Redacted | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 9 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `1:table`.

### Recorded examples

~~~text
shape=redacted
event=CHAT_MSG_CHANNEL_ACTIVE
arguments=1
arg1 type=table
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

**Callbacks:** 3. **Saved examples:** 1.
**Type signature(s):** `1:table`.

~~~text
event=CHAT_MSG_CHANNEL_ACTIVE
arguments=1
arg1 type=table
~~~

Chat-related argument values, including any table fields, were deliberately **not inspected or recorded**. These examples establish callback count and types only.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).


---

## Automated research batch — November 9, 2026 UTC

**Observed callback signatures:** `1:table`. **Saved representative examples:** 1. The `occurrences` counters are cumulative within a watching session and must not be added across flushes or treated as per-example frequencies.

### Captured examples

~~~text
signature=1:table
shape=redacted
event=CHAT_MSG_CHANNEL_ACTIVE
arguments=1
arg1 type=table
~~~

### Interpretation and limits

Payloads were intentionally redacted. Argument count and type are known, but values and table fields cannot be inferred.

**Source:** automated capture snapshots `20261109T013130.298625Z-25441-000001.txt`; permanent review: [November 9 automated session](../research/2026-11-09-automated-review.md).
