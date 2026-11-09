# PLAYER_HOME_CHANGED

**Status:** First observed in a live VO client on November 9, 2026 UTC; argument semantics provisional.

Event callback arguments are supplied after the event name to `OnEvent(event, ...)`.

## Source catalog

[Historical candidate list](../../plugin/APIProbe/events.lua).

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 1. **Saved examples:** 1. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=1:number
shape=number
event=PLAYER_HOME_CHANGED
arguments=1
arg1 type=number value=1219585
~~~

### Interpretation and limitations

**First recorded occurrence:** the callback delivered one numeric value, `1219585`. The same number appeared as `GetCurrentStationID()` during other station-related callbacks in this session, but this event itself had **no contextual getter sample**, so its field meaning is unverified.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
