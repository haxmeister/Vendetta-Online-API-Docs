# TARGET_CHANGED

**Status:** Observed twice in a live VO client on November 8, 2026.

**Callback arguments:** None (`arguments=0`).

~~~text
event=TARGET_CHANGED
arguments=0
~~~

Two callback deliveries had zero additional arguments. The historical `Eventtype` reference also reports no arguments.

To inspect the target after the event, a plugin can call a getter such as `GetTargetInfo()`. In separate live inspections, `GetTargetInfo()` returned no values without a target, and seven values for an asteroid or NPC ship.

No time ordering between the callback and a subsequent getter call was tested in this event survey.

**Sources:** [November 8 live event survey](2026-11-08-live-event-survey.md), [observed getters](../functions/observed-getters.md).
