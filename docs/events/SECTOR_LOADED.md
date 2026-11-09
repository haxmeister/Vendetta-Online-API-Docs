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

No arguments were delivered in any of the eight second-session callbacks. Together with the five earlier observations, this supports a zero-argument callback signature across 13 observed deliveries; other contexts remain untested.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 8. **Saved examples:** 2. Each `occurrences` total applies to the event, not to each example.

### Observed arguments and game state

~~~text
signature=0:
shape=
event=SECTOR_LOADED
arguments=0
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4978]
context.GetCurrentSystemid=1[number:20]
~~~

~~~text
signature=0:
shape=
event=SECTOR_LOADED
arguments=0
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:5823]
context.GetCurrentSystemid=1[number:23]
~~~

### Evidence and interpretation

No callback arguments were recorded. Context showed the current sector and system IDs during two deliveries (`4978`/`20`, `5823`/`23`). The aggregate report does not prove timing relative to `SECTOR_CHANGED`.

**Limitations:** Getter context was read during the callback, not necessarily before the event transition. A matching number is correlation evidence, not universal field semantics.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. Event occurrence counters remain cumulative across flushes, and are not per-example frequencies.

~~~text
signature=0:
shape=
event=SECTOR_LOADED
arguments=0
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4735]
context.GetCurrentSystemid=1[number:19]
~~~

~~~text
signature=0:
shape=
event=SECTOR_LOADED
arguments=0
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4764]
context.GetCurrentSystemid=1[number:19]
~~~

This callback still delivered no arguments. The sector getter reported 4735 or 4764 at callback time; event ordering relative to `SECTOR_CHANGED` is not established.

Examples are not constants or complete schemas; callback-time getter context may reflect transitional state. [Fifth survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013130.298625Z-25441-000001.txt`.
