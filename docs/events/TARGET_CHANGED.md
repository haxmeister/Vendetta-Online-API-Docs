# TARGET_CHANGED

**Status:** Observed in two live client sessions on November 8, 2026.

## Arguments

**Observed callback form:** `()`. Positions exclude the event name passed to `OnEvent(event, ...)`.

No positional callback arguments were observed.

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

**Callback arguments:** None (`arguments=0`).

~~~text
event=TARGET_CHANGED
arguments=0
~~~

Two callback deliveries had zero additional arguments. The historical `Eventtype` reference also reports no arguments.

To inspect the target after the event, a plugin can call a getter such as `GetTargetInfo()`. In separate live inspections, `GetTargetInfo()` returned no values without a target, and seven values for an asteroid or NPC ship.

No time ordering between the callback and a subsequent getter call was tested in this event survey.

**Sources:** [November 8 live event survey](2026-11-08-live-event-survey.md), [observed getters](../functions/observed-getters.md).

---

## Second live collection — November 8, 2026

**Callbacks:** 5 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `0:`.

### Recorded examples

~~~text
shape=
event=TARGET_CHANGED
arguments=0
~~~

### What this tells us

These are representative values from a particular game state, not constants. The precise meaning of each field may require further testing.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 7. **Saved examples:** 2. These are event-wide counts, not frequencies of each sample.

### Observed argument examples and getter context

~~~text
signature=0:
shape=
event=TARGET_CHANGED
arguments=0
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:0.062409638554217,number:3684.7738058122,number:0,string,string,nil]
context.GetTargetDistance=2[number:3684.7738058122,nil]
~~~

~~~text
signature=0:
shape=
event=TARGET_CHANGED
arguments=0
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:1,number:1860.8920575896,number:0,string,string,nil]
context.GetTargetDistance=2[number:1860.8920575896,nil]
~~~

### Evidence and interpretation

The callback still delivered **zero** arguments. Its two contextual `GetTargetInfo()` and `GetTargetDistance()` calls agreed on distance (`3684.7738058122` and `1860.8920575896`), but these are getter values, not event arguments. Target name strings remain type-only in context.

**Limitations:** Getter context was obtained inside the event callback; it does not establish pre-event state or callback ordering.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. The watcher counts event occurrences cumulatively across flushes; they are not per-example frequencies.

~~~text
signature=0:
shape=
event=TARGET_CHANGED
arguments=0
context=callback-time-approved-getters-v1
context.GetTargetInfo=0[]
context.GetTargetDistance=2[nil,nil]
~~~

~~~text
signature=0:
shape=
event=TARGET_CHANGED
arguments=0
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:1,number:1492.4592959274,number:3,string,string,nil]
context.GetTargetDistance=2[number:1492.4592959274,nil]
~~~

Both sampled callbacks delivered **zero arguments**. One found zero `GetTargetInfo()` returns and `(nil,nil)` distance; the other found seven info returns and distance 1492.4592959274, matching `GetTargetDistance()`'s first value. The getter results are not callback arguments.

Getter context was taken *during* the callback, so equal values are correlations rather than proof of a universal signature. [Fifth context survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013130.298625Z-25441-000001.txt`.
