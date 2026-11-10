# IsGuildMember

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `IsGuildMember(int charid) -> bool guildmember`

## Historical description

tell if the provided character is a guild member

### Arguments named by the historical source

- charid character id

### Returns named by the historical source

- gumember true if character is a guildmember false if not or you aren't member of a guild

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_IsGuildMember) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
