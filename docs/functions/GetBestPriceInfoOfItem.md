# GetBestPriceInfoOfItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetBestPriceInfoOfItem(int item) -> int price, station`

## Historical description

Get highest sell price of a cargo item in the active ship in the currentsystem

### Arguments named by the historical source

- item itemid of cargo item

### Returns named by the historical source

- price highest price in system
- station locationid of station with highest price

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- print best prices in system for all cargo items in the ship for _,item in ipairs(GetShipInventory(GetActiveShipID()).cargo) do local price, station = GetBestPriceInfoOfItem(item) print(GetInventoryItemName(item).." "..tostri...`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetBestPriceInfoOfItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
