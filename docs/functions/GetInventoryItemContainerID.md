# GetInventoryItemContainerID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetInventoryItemContainerID(int itemid) -> int container`

## Historical description

get container of item

### Arguments named by the historical source

- itemid inventory item

### Returns named by the historical source

- container itemid of container of or null if it's not in one (a ship)

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetInventoryItemContainerID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
