# UPDATE_CHARINFO

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `1:number`.

### Recorded examples

~~~text
shape=number
event=UPDATE_CHARINFO
arguments=1
arg1 type=number value=30452221
~~~

~~~text
shape=number
event=UPDATE_CHARINFO
arguments=1
arg1 type=number value=30452222
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

**Callbacks:** 2. **Saved examples:** 2.
**Type signature(s):** `1:number`.

~~~text
event=UPDATE_CHARINFO
arguments=1
arg1 type=number value=30460008
~~~

~~~text
event=UPDATE_CHARINFO
arguments=1
arg1 type=number value=30460009
~~~

### Interpretation

One numeric callback argument was observed, with the example above. The captured numbers resemble identifiers but are not independently verified.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 1. Cumulative watcher occurrence counters are not independent event frequencies across flushes.

~~~text
signature=1:number
shape=number
event=UPDATE_CHARINFO
arguments=1
arg1 type=number value=30466963
~~~

One numeric argument 30466963, which also occurred in `PLAYER_GUILD_TAG_UPDATED`. Matching numbers suggest a shared identity reference, but do not prove exact field semantics.

**Source:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), `20261109T014630.304410Z-25441-000005.txt`. Identifier meanings remain provisional.
