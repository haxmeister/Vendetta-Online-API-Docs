# GetStationSellableInventoryPriceByID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationSellableInventoryPriceByID(int itemid, int quantity) -> int value, unitprice`

## Historical description

Get value of inventory items and price per unit in the current station

### Arguments named by the historical source

- itemid itemid of an inventory item in the current station
- quantity number of units of this item (optional)

### Returns named by the historical source

- value value of item(s)
- unitprice price per unit

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetStationSellableInventoryPriceByID(1234, 2) -> 2000, 1400 -- Two units of item 1234 are worth 2000c. The station sells a unit for 1400c.`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationSellableInventoryPriceByID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
