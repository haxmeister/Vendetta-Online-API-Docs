# GetInventoryItemInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetInventoryItemInfo(int itemid) -> string ipath name int quant float mass string sdesc desc1 desc2 int container class subtype`

## Historical description

get most info about inventory item

### Arguments named by the historical source

- itemid inventory item

### Returns named by the historical source

- ipath icon path
- name name or item
- quant amount of items
- mass per item mass as float in tons
- sdesc short description
- desc1 long description
- desc2 long description again, sometimes omitted don't know what's the difference
- container itemid of container this item is in
- class type of item (see GetInventoryItemClassType)
- subtype subtype of item (see GetInventoryItemClassSubType)

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetInventoryItemInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
