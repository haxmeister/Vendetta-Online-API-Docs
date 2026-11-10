# GetGuildBankPrivileges

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetGuildBankPrivileges() -> table deposit withdraw logview`

## Historical description

get your guilds bank privileges as three tables. they contain the ranks carrying each privilege. see [API_Index#Guild]

### Returns named by the historical source

- deposit table with ranks that can deposit money
- withdraw table with ranks that can withdraw money
- logview table with ranks that can view the transfer log

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetGuildBankPrivileges) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
