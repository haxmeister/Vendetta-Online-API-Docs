# GetGuildTag

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetGuildTag(int charid) -> string tag`

## Historical description

get guild tag of self or another character.

### Arguments named by the historical source

- charid character id or nil to get self's guild tag.

### Returns named by the historical source

- tag string containing guild tag or empty string if character not known or not in a guild.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetGuildTag) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
