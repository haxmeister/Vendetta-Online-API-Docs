# GetFullPath

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetFullPath(int sector, table navroute) -> table fullpath`

## Historical description

Get the full path, including wormhole sectors, from sector along navroute

### Arguments named by the historical source

- sector sectorid of starting sectors
- navroute list of sectorids

### Returns named by the historical source

- fullpath navroute plus sectorids of wormhole sectors

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- get full path from Sol a1 to betheshee a1 via sol b1 -- the function adds some duplicate entries GetFullPath(1, {2, 257}) -> {1, 2, 2, 226, 351, 257}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetFullPath) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
