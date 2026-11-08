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
