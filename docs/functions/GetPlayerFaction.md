# GetPlayerFaction

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetPlayerFaction( [ number charid ]) -> number factionid`

**Index2 summary:** `GetPlayerFaction(int charid) -> int factionid`

## Historical description

get nation of a player

### Arguments named by the historical source

- number — charid — character id or nil. Use nil to get current player's faction (optional)

### Returns named by the historical source

- number — factionid — number representing the faction (1-13, 99)

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetPlayerFaction) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
