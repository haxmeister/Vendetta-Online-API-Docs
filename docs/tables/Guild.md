# Guild

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

Guild related functions

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `allowdepositors` | `allowdepositors{int rank, ..} -> string error` | Control who can deposit money into the bank (untested) |
| `allowlogviewers` | `allowlogviewers{int rank, ..} -> string error` | Control who can view the bank transaction log (untested) |
| `allowwithdrawalers` | `allowwithdrawalers{int rank, ..} -> string error` | Control who can withdraw money from the bank (untested) |
| `appoint` | `appoint() -> ?` | appoint a guildmember as lieutenant (untested) |
| `create` | `create(string acronym, name) -> ?` | create a guild |
| `decline` | `create(string name) -> ?` | decline an invitation to a guild(untested) |
| `deposit` | `deposit(int amount, string reason) -> boolean valid` | deposit money into the guild bank |
| `expel` | `expel(string name) -> ?` | expel a guildmember(untested) |
| `getactivitylogpage` | `getactivitylogpage(int page) -> string error` | get activity log page. the function triggers the GUILD_ACTIVITY_LOG event and passes the page to the callback in the registered table. |
| `getbankbalance` | `getbankbalance() -> ?` | get bank balance(?) triggers GUILD_BALANCE_UPDATED event. with no data though |
| `getbanklogpage` | `getbanklogpage(int page) -> string error` | get bank log page. the function triggers the GUILD_BANK_LOG event and passes the page to the callback in the registered table. |
| `withdraw` | `withdraw(int amount, string reason) -> boolean valid` | Attempts to withdraw specified amount of money from guild bank. |
| `RankCommander` | *Not specified* | Not documented |
| `RankCouncil` | *Not specified* | Not documented |
| `RankCouncilLieutenant` | *Not specified* | Not documented |
| `RankLieutenant` | *Not specified* | Not documented |
| `RankMember` | *Not specified* | Not documented |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Guild)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
