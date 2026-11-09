# PLAYER_HIT

**Status:** First observed in a live VO client on November 9, 2026 UTC. Argument meanings are provisional.

## Arguments

**Observed callback form:** `()`. Positions exclude the event name passed to `OnEvent(event, ...)`.

No positional callback arguments were observed.

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

**Observed callback signature(s):** `0:`.

~~~text
signature=0:
shape=
event=PLAYER_HIT
arguments=0
~~~

No callback arguments. Do not conflate this callback with six-argument `PLAYER_GOT_HIT`.

**Evidence:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), snapshot `20261109T015230.303380Z-25441-000007.txt`. Original candidate: [historical catalog](../../plugin/APIProbe/events.lua).
