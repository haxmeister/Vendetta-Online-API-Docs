# GetNumGuildMembers

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetNumGuildMembers() -> int numchars`

## Historical description

get number of online guildmembers

### Returns named by the historical source

- chars number of guildmembers currently online or 0 if player is not in a guild

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`for i=1,GetNumGuildMembers() do local id, rank, name = GetGuildMemberInfo(i) print("member: "..name) end`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetNumGuildMembers) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
