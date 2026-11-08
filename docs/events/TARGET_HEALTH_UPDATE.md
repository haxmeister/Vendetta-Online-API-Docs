# TARGET_HEALTH_UPDATE

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 1 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `2:number,number`.

### Recorded examples

~~~text
shape=number;number
event=TARGET_HEALTH_UPDATE
arguments=2
arg1 type=number value=-1
arg2 type=number value=0
~~~

### What this tells us

The recorded callback had two numbers, `(-1, 0)`. It is not yet clear what each number represents.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.
