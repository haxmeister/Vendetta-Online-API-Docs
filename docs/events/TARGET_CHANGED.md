# TARGET_CHANGED

**Status:** Observed in two live client sessions on November 8, 2026.

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
