# GetPlayerNodeID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetPlayerNodeID(int charid) -> int nodeid`

## Historical description

get nodeid of a character in the sector

### Arguments named by the historical source

- charid character id

### Returns named by the historical source

- nodeid nodeid or nil if charid is invalid

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetPlayerNodeID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
