# StationPlayerAmmoPairs

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `StationPlayerAmmoPairs() -> int itemid table ammoinfo`

## Historical description

Iterator function that prints information about ammo based weapons in the players inventory at the current station each time it is called. works like pairs()

### Returns named by the historical source

- itemid itemid
- iteminfo ammoinfo

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`for i,v in StationPlayerAmmoPairs() do console_print(i) printtable(v) end`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_StationPlayerAmmoPairs) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
