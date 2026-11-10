# GetStartingSectors

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStartingSectors(int factionid) -> table sectors`

## Historical description

get list of starting sectors for the given faction

### Arguments named by the historical source

- factionid factionid

### Returns named by the historical source

- sectors table with sectorids of the starting sectors or 0 if the faction has none

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStartingSectors) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
