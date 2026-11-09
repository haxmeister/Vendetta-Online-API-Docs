# PLAYER_UPDATE_SKILLS

**Status:** First observed in a live VO client on November 9, 2026 UTC. Argument meanings are provisional.

## Arguments

**Observed callback form:** `(number)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `number` | Not identified | `345929` | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

**Observed callback signature(s):** `1:number`.

~~~text
signature=1:number
shape=number
event=PLAYER_UPDATE_SKILLS
arguments=1
arg1 type=number value=345929
~~~

One numeric argument `345929`. Its identifier semantics are not yet confirmed.

**Evidence:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), snapshot `20261109T015530.300917Z-25441-000008.txt`. Original candidate: [historical catalog](../../plugin/APIProbe/events.lua).
