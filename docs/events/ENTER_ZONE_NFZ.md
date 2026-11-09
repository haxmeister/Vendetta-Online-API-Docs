# ENTER_ZONE_NFZ

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

## Arguments

**Observed callback form:** `(string)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `string` | Zone label | `"NFZ"` | High |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 2. **Observed argument type(s):** (`string`).
**Captured example(s):** `("NFZ")`.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `1:string`.

### Recorded examples

~~~text
shape=string
event=ENTER_ZONE_NFZ
arguments=1
arg1 type=string value="NFZ" (bytes=3)
~~~

### What this tells us

These are representative values from a particular game state, not constants. The precise meaning of each field may require further testing.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## Fourth live session — November 9, 2026 UTC

**Callbacks:** 3. **Saved examples:** 1.
**Type signature(s):** `1:string`.

~~~text
event=ENTER_ZONE_NFZ
arguments=1
arg1 type=string value="NFZ" (bytes=3)
~~~

The callback carried a string indicating the observed zone. These strings are representative examples, not a guarantee of all possible values.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).


---

## Automated research batch — November 9, 2026 UTC

**Observed callback signatures:** `1:string`. **Saved representative examples:** 1. The `occurrences` counters are cumulative within a watching session and must not be added across flushes or treated as per-example frequencies.

### Captured examples

~~~text
signature=1:string
shape=string
event=ENTER_ZONE_NFZ
arguments=1
arg1 type=string value="NFZ" (bytes=3)
~~~

### Interpretation and limits

Argument meanings and ordering beyond the recorded types remain provisional. Callback-time getter context reflects state during the callback, not necessarily before the event.

**Source:** automated capture snapshots `20261109T013130.298625Z-25441-000001.txt`; permanent review: [November 9 automated session](../research/2026-11-09-automated-review.md).
