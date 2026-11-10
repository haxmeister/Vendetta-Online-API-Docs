# GetStorageItemInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStorageItemInfo(int itemid) -> int stationid :: get stationid of a storage container`

**Index2 summary:** `GetStorageItemInfo(int itemid) -> int stationid`

## Historical description

get location of a storage container (station storage)

### Arguments named by the historical source

- itemid itemid of a storage container

### Returns named by the historical source

- stationid stationid or nil if itemid is invalid or points to an item that is not a storage container

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStorageItemInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
