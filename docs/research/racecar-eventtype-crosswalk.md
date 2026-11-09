# Racecar Eventtype — historical comparison with live captures

**Source:** [Racecar Eventtype (revision 14149)](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149), last edited March 19, 2024; reviewed against the live captures documented in [our event reference](../events/index.md). The source was provided as a PDF of this revision.

## Evidence precedence

1. **Live captures govern the observed callback signatures.** Every argument count, Lua type, and recorded example in the reference is based on captured client behavior.
2. **Historical descriptions explain possible meaning and triggers.** They are useful leads but not independent verification of an argument's identity or table structure.
3. **Conflicts stay visible.** We preserve the historical account and explicitly say what current captures actually delivered. We neither erase differences nor silently merge inconsistent field names.
4. **Unobserved candidates remain unobserved.** A claimed legacy signature is not a captured modern signature, and privacy-redacted chat tables cannot be reverse-engineered from historical prose.

## Important comparison cases

| Event | Racecar account | Live result and priority |
| --- | --- | --- |
| [`PLAYER_GOT_HIT`](../events/PLAYER_GOT_HIT.md) | Describes four argument meanings | **Six actual positions**: number, number, number, boolean, number, userdata. Extra two positions remain unidentified |
| [`PLAYER_DIED`](../events/PLAYER_DIED.md) | Deceased ID, killer ID, weapon ID; omits fourth | **Four actual numbers**, with fourth repeatedly matching current sector |
| [`CHAT_MSG_SERVER_SECTOR`](../events/CHAT_MSG_SERVER_SECTOR.md) | Message string | **One table**; contents redacted |
| [`MISSION_QUESTION_OPEN`](../events/MISSION_QUESTION_OPEN.md) | Third field a mission-ID string illustrated with digits | **Third field `"db:1009"`** in live capture; preserve actual string |
| [`PLAYER_ENTERED_SECTOR`](../events/PLAYER_ENTERED_SECTOR.md) | Discusses a possible initial zero/multi-value form | **One number** in observed callback forms; initial-entry claim untested |
| [`SYSTEM_BEST_PRICE`](../events/SYSTEM_BEST_PRICE.md) | Item ID, sale price, best station | **Three numbers** observed; names are still historical hypotheses |
| [`TARGET_SCANNED`](../events/TARGET_SCANNED.md) | Scan text, node ID, object ID | **String, number, number** observed; only scan-result text identified with high confidence |
| [`COMMAND`](../events/COMMAND.md) | Command ID and argument list | Observed **one-number** or **number-and-table** forms; contents privacy-redacted |

## Maintenance

Review a Racecar description alongside the relevant live event page. Put a concise `Historical Racecar reference` section on the individual page without modifying its observed signature. When new captures conflict with Racecar, revise the **live** conclusions from the evidence, then update the comparison note. Do not treat Racecar as the current game API specification.
