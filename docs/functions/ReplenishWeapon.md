# ReplenishWeapon

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ReplenishWeapon(int itemid, int x, func cb) -> nil`

**Index2 summary:** `ReplenishWeapon() -> ??`

## Historical description

Repairs the ship if itemid is a ship. Not tested on weapon IDs yet. The meaning of x is unknown. 1 seems to work as a value. See also API_ReplenishAll and API_RepairShip.

### Arguments named by the historical source

- itemid itemid of ship or possibly weapon
- x unknown, number 1 seems to work
- cb function to be called once the transaction is complete

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ReplenishWeapon) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
