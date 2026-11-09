# CONQUERED_SECTORS_UPDATED

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 2 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `1:table`.

### Recorded examples

~~~text
shape=table{27:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[27]=true}
~~~

~~~text
shape=table{8:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[8]=true}
~~~

### What this tells us

The callback delivered tables with one numeric key and boolean `true`: `[27]=true` and `[8]=true`. The meaning of these keys is not established by the type and value alone.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 4. **Argument signature(s):** `1:table`.

### Recorded examples

~~~text
signature=1:table
shape=table{20:boolean,22:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[20]=true, [22]=true}
~~~

~~~text
signature=1:table
shape=table{30:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[30]=true}
~~~

~~~text
signature=1:table
shape=table{6:boolean,8:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[6]=true, [8]=true}
~~~

~~~text
signature=1:table
shape=table{6:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[6]=true}
~~~

### Interpretation

This session added four example table shapes, including multiple numeric keys mapped to boolean `true`: `[20]` and `[22]` together, plus `[30]`, `[6]` with `[8]`, and `[6]` alone. These are bounded examples, not a complete set of keys or evidence of what `false` means.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 2. **Saved examples:** 2. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=1:table
shape=table{27:boolean,30:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[27]=true, [30]=true}
~~~

~~~text
signature=1:table
shape=table{6:boolean}
event=CONQUERED_SECTORS_UPDATED
arguments=1
arg1 type=table value=table{[6]=true}
~~~

### Interpretation and limitations

The two table examples contained boolean `true` at numeric keys `[27]` and `[30]` together, and at `[6]` alone. Earlier sessions also contained other key combinations. The meaning of these keys and whether missing keys imply false is unknown.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
