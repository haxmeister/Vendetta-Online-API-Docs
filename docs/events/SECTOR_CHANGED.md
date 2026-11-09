# SECTOR_CHANGED

**Status:** Observed in two live client sessions on November 8, 2026.

**Callback arguments:** `(number sectorid)`

~~~text
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=5570
~~~

Four callback deliveries had this one-number signature. The sampled value was `5570`. The historical `Eventtype` reference describes the argument as a sector ID, which is consistent with the observation.

The separate `SECTOR_LOADED` event was observed four times with zero arguments during the same session. The aggregated report did not capture callback order, so the relative timing of these events is not yet verified.

**Source:** [November 8 live event survey](2026-11-08-live-event-survey.md).

---

## Second live collection — November 8, 2026

**Callbacks:** 8 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `1:number`.

### Recorded examples

~~~text
shape=number
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=4978
~~~

~~~text
shape=number
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=5823
~~~

### What this tells us

These are representative values from a particular game state, not constants. The precise meaning of each field may require further testing.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 8. **Saved examples:** 2. Each `occurrences` total applies to the event, not to each example.

### Observed arguments and game state

~~~text
signature=1:number
shape=number
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=4978
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4978]
context.GetCurrentSystemid=1[number:20]
context.PlayerInStation=1[boolean:false]
~~~

~~~text
signature=1:number
shape=number
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=5823
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:5823]
context.GetCurrentSystemid=1[number:23]
context.PlayerInStation=1[boolean:false]
~~~

### Evidence and interpretation

In both sampled callbacks, the event's sole numeric argument matched the contemporaneous `GetCurrentSectorid()` result (`4978` and `5823`). This is strong initial evidence that the argument denotes the current sector ID, though the captures cannot prove every context behaves identically.

**Limitations:** Getter context was read during the callback, not necessarily before the event transition. A matching number is correlation evidence, not universal field semantics.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
