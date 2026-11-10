# GetShipMeshInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetShipMeshInfo(int itemid) -> string id model int color`

## Historical description

get mesh information about equipment in your inventory. if an invalid itemid is given the info about the current ship is returned

### Arguments named by the historical source

- itemid itemid of one of your ships or nil

### Returns named by the historical source

- id of the ship
- model filename of the model(?)
- color colorid of the item see ShipPalette

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetShipMeshInfo(1234) -> "ship_generic_behemoth" "gaf/ship_generic_behemoth.dfs" 166`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetShipMeshInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
