# GetInventoryItemLocation

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetInventoryItemLocation(int itemid) -> int stationid`

## Historical description

get location of an inventory item

### Arguments named by the historical source

- itemid itemid of an inventory item

### Returns named by the historical source

- stationid stationid or nil if itemid is invalid

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`ShortLocationStr(SplitStationID(GetInventoryItemLocation(1234))) -> "Dau L-10"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetInventoryItemLocation) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
