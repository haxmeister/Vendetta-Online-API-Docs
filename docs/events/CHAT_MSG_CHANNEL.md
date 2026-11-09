# CHAT_MSG_CHANNEL

**Status:** First observed in a live VO client on November 9, 2026 UTC. Argument meanings are provisional.

## Arguments

**Observed callback form:** `(table)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `table` | Not identified | Redacted | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

**Observed callback signature(s):** `1:table`.

Chat-related values and table fields were not recorded to protect privacy.

One table argument was delivered. All chat fields and values were intentionally redacted.

**Evidence:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), snapshot `20261109T015230.303380Z-25441-000007.txt`. Original candidate: [historical catalog](../../plugin/APIProbe/events.lua).
