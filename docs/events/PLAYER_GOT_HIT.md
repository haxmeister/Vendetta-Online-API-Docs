# PLAYER_GOT_HIT

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `6:number,number,number,boolean,number,userdata`.

### Recorded examples

~~~text
shape=number;number;number;boolean;number;userdata
event=PLAYER_GOT_HIT
arguments=6
arg1 type=number value=345929
arg2 type=number value=883607
arg3 type=number value=1302
arg4 type=boolean value=true
arg5 type=number value=2
arg6 type=userdata value=<userdata>
~~~

~~~text
shape=number;number;number;boolean;number;userdata
event=PLAYER_GOT_HIT
arguments=6
arg1 type=number value=345929
arg2 type=number value=883607
arg3 type=number value=1316
arg4 type=boolean value=true
arg5 type=number value=2
arg6 type=userdata value=<userdata>
~~~

### What this tells us

Six callback arguments were observed: `(number, number, number, boolean, number, userdata)`. The userdata is intentionally not traversed. The relationship among these fields remains unverified.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.
