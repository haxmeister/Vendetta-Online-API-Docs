# GetActiveShipPortIDOfItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetActiveShipPortIDOfItem(int itemid) -> int portid`

## Historical description

returns portid of the given addon in active ship

### Arguments named by the historical source

- itemid itemid of an addon

### Returns named by the historical source

- portid portid of port the addon is in or nil if addon is not on the ship or invalid

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetActiveShipPortIDOfItem(1234) -> 3`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveShipPortIDOfItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
