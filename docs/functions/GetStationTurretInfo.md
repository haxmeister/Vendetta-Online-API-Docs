# GetStationTurretInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationTurretInfo(int turretid) -> {...}`

**Index2 summary:** `GetStationTurretInfo(int turretid) -> {int objectid, int nodeid, float armorpercent, int itemid}`

## Historical description

get information about a stations or ships turrets. Return table has different members for occupied vs unoccupied turrets.

### Arguments named by the historical source

- turretid' id of a turret
- Returns when unoccupied:
- ammo Remaining ammo. -1 for unlimited fire weapons
- armorpercent armor level
- itemid
- itemtype
- nodeid
- objectid
- Additional data when occupied:
- controller charid of the player who is controlling the turret.
- _controller nodeid of the player who is controlling the turret?

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationTurretInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
