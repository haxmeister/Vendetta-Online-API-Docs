# GetAddonItemInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetAddonItemInfo( number itemid) -> number current, number maximum [, string name ]`

**Index2 summary:** `GetAddonItemInfo(int itemid) -> int current maximum`

## Historical description

Returns current and maximum ammo if itemid is a weapon with ammo, or current/maximum armor if itemid is a ship.

### Arguments named by the historical source

- number — itemid — itemid of an addon or ship.

### Returns named by the historical source

- number — current — Current ammo/armor, or -1.
- number — maximum — Maximum ammo/armor, or -1.
- string — name — Name of weapon addon, otherwise nil

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetAddonItemInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
