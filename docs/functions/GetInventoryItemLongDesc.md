# GetInventoryItemLongDesc

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetInventoryItemLongDesc(int itemid) -> string desc`

## Historical description

get long description of an inventory item

### Arguments named by the historical source

- itemid itemid of an inventory item

### Returns named by the historical source

- desc long description of an inventory item

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetInventoryItemLongDesc(1234) -> "Damage: 1100\|Velocity: 190m/s\|Energy: 30/blast\|Delay: 0.4s\|Mass: 1000 kg\| \ Volume (as cargo): 1 cu\|Good auto-targeting\|\|KC-Cannon housing with PR-11 plasma cells"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetInventoryItemLongDesc) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
