# GetShipPortIDOfItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetShipPortIDOfItem(int itemid1, int itemid2) -> int portid`

## Historical description

get port of weapon in one of your ships

### Arguments named by the historical source

- itemid1 itemid of one of your ships
- itemid2 itemid of a weapon or nil

### Returns named by the historical source

- portid port of a wweapon or first free port if itemid2 is nil

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetShipPortIDOfItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
