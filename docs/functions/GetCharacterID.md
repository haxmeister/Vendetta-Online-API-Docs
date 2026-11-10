# GetCharacterID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetCharacterID(int nodeid) -> int charid`

## Historical description

returns character id of the provided node id

### Arguments named by the historical source

- nodeid node id of one of the characters in the sector

### Returns named by the historical source

- charid character id of the given node if a valid nodeid is valid otherwise the players charid

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetCharacterID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
