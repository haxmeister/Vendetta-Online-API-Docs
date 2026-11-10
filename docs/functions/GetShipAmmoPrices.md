# GetShipAmmoPrices

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetShipAmmoPrices(int ship) -> table prices`

## Historical description

get cost of ship ammo

### Arguments named by the historical source

- ship itemid of a ship

### Returns named by the historical source

- prices weapon itemid ammo price pairs
- prices.allammoprice cost of reloading all weapons
- prices.allammoquantity amoutn of ammo to reload

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetShipAmmoPrices) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
