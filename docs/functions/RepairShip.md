# RepairShip

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `RepairShip(int itemid, int x, func cb) -> nil`

## Historical description

Repairs the ship itemid in the station. Tested with active ship id. The cb is a callback function which is called after the ship is repaired. x is unknown, but a value of 1 seems to work. See also API_ReplenishWeapon and API_ReplenishAll.

### Arguments named by the historical source

- itemid itemid of ship
- x unknown, number 1 seems to work
- cb function to be called once the transaction is complete

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_RepairShip) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
