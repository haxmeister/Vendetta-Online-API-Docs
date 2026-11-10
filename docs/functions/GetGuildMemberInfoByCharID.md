# GetGuildMemberInfoByCharID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetGuildMemberInfoByCharID(int charid) -> int charid rank string name`

## Historical description

get information about the guildmember

### Arguments named by the historical source

- charid charid of online guildmember

### Returns named by the historical source

- charid character id
- rank rank: 0=member, 1=lieutenant, 2=council member, 3=council member and lieutenant, 4=commander
- name name of member

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`local charid,rank,charname = GetGuildMemberInfoByCharID(GetCharacterID())`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetGuildMemberInfoByCharID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
