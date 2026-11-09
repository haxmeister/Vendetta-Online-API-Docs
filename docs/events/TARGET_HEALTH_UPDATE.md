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

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. The watcher counts event occurrences cumulatively across flushes; they are not per-example frequencies.

~~~text
signature=2:number,number
shape=number;number
event=TARGET_HEALTH_UPDATE
arguments=2
arg1 type=number value=-1
arg2 type=number value=0
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:1,number:2608.4965976593,number:3,string,string,nil]
context.GetTargetDistance=2[number:2608.4965976593,nil]
~~~

~~~text
signature=2:number,number
shape=number;number
event=TARGET_HEALTH_UPDATE
arguments=2
arg1 type=number value=90
arg2 type=number value=0
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:0.90614457831325,number:138.11795796528,number:9,string,string,nil]
context.GetTargetDistance=2[number:138.11795796528,nil]
~~~

The callbacks delivered `(-1,0)` and `(90,0)`. With 90, the target-info second return was `0.90614457831325` (about 90.6%). This is suggestive, but **does not establish** percentage scaling, rounding or the meaning of -1.

Getter context was taken *during* the callback, so equal values are correlations rather than proof of a universal signature. [Fifth context survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013730.312126Z-25441-000003.txt`, `20261109T015230.303380Z-25441-000007.txt`.
