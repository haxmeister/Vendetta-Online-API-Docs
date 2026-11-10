# GetNumStationDesiredItems

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetNumStationDesiredItems() -> int num`

## Historical description

Get number of items this station desires. The names of the items can then be fetched with GetStationDesiredItem.

### Returns named by the historical source

- num The number of items the station wants.

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`for i = 1, GetNumStationDesiredItems(), 1 do print("This station wants: "..GetStationDesiredItem(i)) done`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetNumStationDesiredItems) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
