# PLAYER_GUILD_TAG_UPDATED

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `1:number`.

### Recorded examples

~~~text
shape=number
event=PLAYER_GUILD_TAG_UPDATED
arguments=1
arg1 type=number value=30452221
~~~

~~~text
shape=number
event=PLAYER_GUILD_TAG_UPDATED
arguments=1
arg1 type=number value=30452222
~~~

### What this tells us

The callback delivered numeric values `30452221` and `30452222`. The numbers may be identifiers, but the capture alone does not establish that.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.
