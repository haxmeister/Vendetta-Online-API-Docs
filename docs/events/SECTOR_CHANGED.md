# SECTOR_CHANGED

**Status:** Observed four times in a live VO client on November 8, 2026.

**Callback arguments:** `(number sectorid)`

~~~text
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=5570
~~~

Four callback deliveries had this one-number signature. The sampled value was `5570`. The historical `Eventtype` reference describes the argument as a sector ID, which is consistent with the observation.

The separate `SECTOR_LOADED` event was observed four times with zero arguments during the same session. The aggregated report did not capture callback order, so the relative timing of these events is not yet verified.

**Source:** [November 8 live event survey](2026-11-08-live-event-survey.md).
