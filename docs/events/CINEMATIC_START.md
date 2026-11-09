# CINEMATIC_START

**Status:** Observed in two live client sessions on November 8, 2026; argument meaning unconfirmed.

**Callback arguments:** One argument, but **two types observed**:

~~~text
event=CINEMATIC_START
arguments=1
arg1 type=boolean value=false
~~~

and

~~~text
event=CINEMATIC_START
arguments=1
arg1 type=number value=4
~~~

The nine occurrences are the **combined event count** from the broad watcher; the capture does not distinguish how often each argument type occurred.

The historical `Eventtype` reference says this event is raised for in-game cinematics, including undocking and warping. We have **not** established whether the numeric value identifies a cinematic, whether the boolean controls its behavior, or which activities yielded each signature.

For now, consumers should handle both argument types and avoid assuming that a number will always be provided.

**Source:** [November 8 live event survey](2026-11-08-live-event-survey.md).

---

## Second live collection — November 8, 2026

**Callbacks:** 17 (total for this event). **Saved examples:** 3.
**Observed argument-type signature(s):** `1:boolean` or `1:number`.

### Recorded examples

~~~text
shape=boolean
event=CINEMATIC_START
arguments=1
arg1 type=boolean value=false
~~~

~~~text
shape=number
event=CINEMATIC_START
arguments=1
arg1 type=number value=4
~~~

~~~text
shape=number
event=CINEMATIC_START
arguments=1
arg1 type=number value=6
~~~

### What this tells us

This session repeated the boolean argument `false` and numeric argument `4`, and introduced numeric `6`. Consumers should not assume a single argument type.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 1. **Observed callback form(s):** `0:`.

### Recorded examples

~~~text
signature=0:
shape=
event=CINEMATIC_START
arguments=0
~~~

### Interpretation

**New signature:** This observation had zero callback arguments. Earlier live captures supplied one boolean or one numeric argument. Plugins must tolerate all three observed forms; 33 is the event-wide counter, not a count of zero-argument invocations.

**Occurrence-count caveat:** The watcher retains event counters across flushes. The counts reported with these examples are cumulative at the time of capture; they cannot be added to counts from earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), captured in `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 19. **Saved examples:** 5. These are event-wide counts, not frequencies of each sample.

### Observed argument examples and getter context

~~~text
signature=0:
shape=
event=CINEMATIC_START
arguments=0
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:false]
context.GetCurrentSectorid=1[number:4764]
~~~

~~~text
signature=1:boolean
shape=boolean
event=CINEMATIC_START
arguments=1
arg1 type=boolean value=false
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:false]
context.GetCurrentSectorid=1[number:4978]
~~~

~~~text
signature=1:boolean
shape=boolean
event=CINEMATIC_START
arguments=1
arg1 type=boolean value=false
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:false]
context.GetCurrentSectorid=1[number:5076]
~~~

~~~text
signature=1:number
shape=number
event=CINEMATIC_START
arguments=1
arg1 type=number value=4
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:false]
context.GetCurrentSectorid=1[number:5076]
~~~

~~~text
signature=1:number
shape=number
event=CINEMATIC_START
arguments=1
arg1 type=number value=6
context=callback-time-approved-getters-v1
context.PlayerInStation=1[boolean:false]
context.GetCurrentSectorid=1[number:4978]
~~~

### Evidence and interpretation

This session captured **three distinct signatures**: zero arguments, one boolean (`false`), and one number (`4` or `6`). All shown contextual samples had `PlayerInStation() = false`; there is no evidence to assign a meaning to the boolean or numeric values yet.

**Limitations:** Getter context was obtained inside the event callback; it does not establish pre-event state or callback ordering.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
