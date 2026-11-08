# TARGET_SCANNED

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 21 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `3:string,number,number`.

### Recorded examples

~~~text
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Cargo Hold Empty\
" (bytes=17)
arg2 type=number value=3
arg3 type=number value=1292
~~~

~~~text
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Ship too far to scan\
" (bytes=21)
arg2 type=number value=3
arg3 type=number value=1292
~~~

### What this tells us

The observed scan messages were “Cargo Hold Empty” and “Ship too far to scan”, with a terminating newline in each string, followed by the numbers `3` and `1292`. The numeric fields are not yet identified.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.
