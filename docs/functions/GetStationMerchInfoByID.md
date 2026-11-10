# GetStationMerchInfoByID

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationMerchInfoByID(int itemid) -> { neededlevels = {int l1 .. l5}, int price, string longdesc, float mass, string sortgroup, int volume, string extendeddesc, string type, string meshfile, bool usable, int itemid, string icon }`

## Historical description

get info about items this station sells by itemid

### Arguments named by the historical source

- itemid itemid of sold items

### Other names in the historical table-return notation

`extendeddesc`, `icon`, `itemid`, `l1`, `longdesc`, `mass`, `meshfile`, `price`, `sortgroup`, `type`, `usable`, `volume`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

### Named table members in the historical signature

`neededlevels`

These member names come from the historical return/argument notation; **their current presence and types have not been verified**.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationMerchInfoByID) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
