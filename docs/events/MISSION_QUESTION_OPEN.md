# MISSION_QUESTION_OPEN

**Status:** First observed in a live VO client on November 9, 2026 UTC. Argument meanings are provisional.

## Arguments

**Observed callback form:** `(string, string, string, number)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `string` | Information/question text | `"This mission relays some brief information about where…` | Tentative |
| 2 | `string` | Short label string | `"Info"` | Tentative |
| 3 | `string` | Not identified | `"db:1009"` | Unknown |
| 4 | `number` | Not identified | `1219585` | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

**Observed callback signature(s):** `4:string,string,string,number`.

~~~text
signature=4:string,string,string,number
shape=string;string;string;number
event=MISSION_QUESTION_OPEN
arguments=4
arg1 type=string value="This mission relays some brief information about where to go once you complete you training, and what possibilities await you in the galaxy." (bytes=140)
arg2 type=string value="Info" (bytes=4)
arg3 type=string value="db:1009" (bytes=7)
arg4 type=number value=1219585
~~~

Four arguments: a 140-byte informational string, `"Info"`, `"db:1009"`, and `1219585`. That final number also appears as a station ID during other events, but this callback has no direct simultaneous getter comparison; its field meaning is unverified.

**Evidence:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), snapshot `20261109T014330.306885Z-25441-000004.txt`. Original candidate: [historical catalog](../../plugin/APIProbe/events.lua).
