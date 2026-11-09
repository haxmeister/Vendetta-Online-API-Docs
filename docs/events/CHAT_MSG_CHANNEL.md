# CHAT_MSG_CHANNEL

**Status:** First observed in a live VO client on November 9, 2026 UTC. Argument meanings are provisional.

## Arguments

**Observed callback form:** `(table)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `table` | Not identified | Redacted | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar describes a message received on an inactive chat channel.

**Historical argument descriptions:** It suggests a table containing `name`, `msg`, `faction`, and `channelid`.

**Live evidence:** One table argument was observed, but chat values **and field names** were redacted. The suggested table schema is historical only and must not be described as independently observed.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149), last edited March 19, 2024. These claims are not live verification.


---

**Observed callback signature(s):** `1:table`.

Chat-related values and table fields were not recorded to protect privacy.

One table argument was delivered. All chat fields and values were intentionally redacted.

**Evidence:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), snapshot `20261109T015230.303380Z-25441-000007.txt`. Original candidate: [historical catalog](../../plugin/APIProbe/events.lua).
