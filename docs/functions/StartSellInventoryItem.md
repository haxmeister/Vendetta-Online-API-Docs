# StartSellInventoryItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `StartSellInventoryItem(int itemid, function cb) -> nil`

## Historical description

Receive instant price updates for the given item.

### Arguments named by the historical source

- itemid itemid of inventory item for which to receive instant price updates. Pass 0 to disable updates. cb function to call on success

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_StartSellInventoryItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
