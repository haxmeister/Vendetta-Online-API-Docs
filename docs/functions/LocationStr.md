# LocationStr

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `LocationStr(int sectorid) -> string sname`

## Historical description

translate a sectorid into a sector name. error if no argument provided

### Arguments named by the historical source

- sectorid sectorid

### Returns named by the historical source

- sname sector name

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`LocationStr(5000) -> "Sedina System, Sector H-9"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_LocationStr) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
