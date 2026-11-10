# LoadNavpath

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `LoadNavpath(string navpath) -> {int sectorid1 ..}`

## Historical description

load navroute by name and return array with hops

### Returns named by the historical source

- sectorid1 sectorid of a hop on this navroute first index is first hop (1-n)

### Other names in the historical table-return notation

`sectorid1`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_LoadNavpath) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
