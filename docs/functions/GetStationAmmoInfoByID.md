# GetStationAmmoInfoByID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationAmmoByID(int itemid) -> {bool is_ammorepair, string type, int unitcost, int price, string longdesc, string desc, bool locallyproduced, int itemid, string icon}`

**Index2 summary:** `GetStationAmmoInfoByID(int itemid) -> {bool is_ammorepair, string type, int unitcost, int price, string longdesc, string desc, bool locallyproduced, int itemid, string icon}`

## Historical description

get info about ammo based weapons in the station by item id

### Arguments named by the historical source

- itemid itemid

### Other names in the historical table-return notation

`desc`, `icon`, `is_ammorepair`, `itemid`, `locallyproduced`, `longdesc`, `price`, `type`, `unitcost`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationAmmoInfoByID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
