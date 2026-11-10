# SellInventoryItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `SellInventoryItem(int itemid, int amount) -> nil`

## Historical description

Sell the provided amount of an inventory item from the current station or ship when docked to a station

### Arguments named by the historical source

- itemid itemid of an item at the current station
- amount how many to sell

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_SellInventoryItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
