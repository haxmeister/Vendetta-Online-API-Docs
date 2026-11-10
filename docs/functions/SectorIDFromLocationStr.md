# SectorIDFromLocationStr

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `SectorIDFromLocationStr(string location) -> int sectorid`

## Historical description

Convert a location string into a sectorid. For two word system names only first word must be specified, otherwise it doesn't work (e.g. Geira rather than Geira Rutilus).

### Arguments named by the historical source

- location location string. output of API_Index#ShortLocationStr

### Returns named by the historical source

- sectorid sectorid

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`SectorIDFromLocationStr("Sedina H-9") -> 5000`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_SectorIDFromLocationStr) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
