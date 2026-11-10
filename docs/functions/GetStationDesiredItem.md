# GetStationDesiredItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationDesiredItem(int index) -> string ditem`

## Historical description

Get the string name of an item that this station desires. The index ranges from 1 to GetNumStationDesiredItems().

### Arguments named by the historical source

- index index in list of strings

### Returns named by the historical source

- ditems desired item

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationDesiredItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
