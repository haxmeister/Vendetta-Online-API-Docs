# GetInventoryItemClassSubType

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetInventoryItemClassSubType(int itemid) -> int subtype`

## Historical description

get subclass of an item

### Arguments named by the historical source

- itemid inventory item

### Returns named by the historical source

- subtype sub type of item
- known types:
- 0 = light weapon or ship
- 1 = heavy weapon
- 3 = engine
- 4 = battery
- 10 = trade goods

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetInventoryItemClassSubType) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
