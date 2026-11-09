# SYSTEM_BEST_PRICE

**Status:** First observed in a live VO client on November 9, 2026 UTC. Argument meanings are provisional.

## Arguments

**Observed callback form:** `(number, number, number)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `number` | Not identified | `14177` | Unknown |
| 2 | `number` | Not identified | `380` | Unknown |
| 3 | `number` | Not identified | `506701` | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

**Observed callback signature(s):** `3:number,number,number`.

~~~text
signature=3:number,number,number
shape=number;number;number
event=SYSTEM_BEST_PRICE
arguments=3
arg1 type=number value=14177
arg2 type=number value=380
arg3 type=number value=506701
~~~

Three numeric arguments `(14177,380,506701)`. Their meanings have not been established.

**Evidence:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), snapshot `20261109T015530.300917Z-25441-000008.txt`. Original candidate: [historical catalog](../../plugin/APIProbe/events.lua).
