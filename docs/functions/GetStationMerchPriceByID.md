# GetStationMerchPriceByID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationMerchInfoByID(int itemid) -> int price`

**Index2 summary:** `GetStationMerchPriceByID(int itemid) -> int price`

## Historical description

get price of an item this station sells

### Arguments named by the historical source

- itemid itemid of sold items

### Returns named by the historical source

- price price of an item or 0 if this item isn't sold

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationMerchPriceByID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
