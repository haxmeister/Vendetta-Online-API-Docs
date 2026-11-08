# SECTOR_LOADED

**Status:** Observed in two live sessions plus an earlier isolated capture; other contexts may vary.

**Arguments:** No additional arguments were recorded after the event name (`arguments=0`).

**Observed behavior:** Earlier testing recorded this event once during travel from Dau L-10 to Dau O-8. A second broad observation session recorded **four additional deliveries**, also with zero arguments, while the client changed sectors.

**Evidence:**

~~~text
event=SECTOR_LOADED
arguments=0
~~~

A separate event, `SECTOR_CHANGED`, delivered one numeric sector ID in the same broad observation session. The aggregate snapshot did not record individual event timestamps or ordering, so **we cannot establish that SECTOR_LOADED always occurs after SECTOR_CHANGED from this capture alone**.

**Sources:** [November 8 live event survey](2026-11-08-live-event-survey.md), [first local event observation](../research/2026-11-08-observation-review.md). Observations from the November 8, 2026 VO client.

---

## Second live collection — November 8, 2026

**Callbacks:** 8 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `0:`.

### Recorded examples

~~~text
shape=
event=SECTOR_LOADED
arguments=0
~~~

### What this tells us

These are representative values from a particular game state, not constants. The precise meaning of each field may require further testing.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.
