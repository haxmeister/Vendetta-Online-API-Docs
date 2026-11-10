# GetLastShipLoadout

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetLastShipLoadout() -> {groups = {1 = group1 .. 18 = group18}, int ship, ports= {1 = port1 ..}, int shipcolor, int overlayindex}`

**Index2 summary:** `GetLastShipLoadout() -> {groups = {1 = group1 .. 18 = group18}, int ship, ports= {1 = port1 ..}, int shipcolor}`

## Historical description

get last ship loadout, color and weapon groups. this function only works in space

### Returns named by the historical source

- groups table containing the weapon group setup
- group? group information. array indices correspondent to ports, is the value of an index set to true the port is enabled
- ship type of ship
- ports array indices correspondent to ports, value of index is the type of addon
- shipcolor ship color 0-255
- overlayindex ship livery

### Other names in the historical table-return notation

`overlayindex`, `ship`, `shipcolor`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

### Named table members in the historical signature

`groups`, `ports`

These member names come from the historical return/argument notation; **their current presence and types have not been verified**.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetLastShipLoadout) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
