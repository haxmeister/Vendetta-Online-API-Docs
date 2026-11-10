# GetShipInventory

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetShipInventory(int itemid) -> {cargo = {int cargoitemid ..}, addons = {int addonitemid ..}}`

## Historical description

get itemids of items attached to a ship

### Arguments named by the historical source

- itemid item id of a ship

### Returns named by the historical source

- cargo array with cargo items
- addons array with addons
- cargoitemid itemids of cargo items
- addonitemid itemids of addons

### Other names in the historical table-return notation

`addonitemid`, `cargoitemid`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

### Named table members in the historical signature

`addons`, `cargo`

These member names come from the historical return/argument notation; **their current presence and types have not been verified**.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetShipInventory) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
