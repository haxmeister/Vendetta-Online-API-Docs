# AbbrLocationStr

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `AbbrLocationStr( number sectorid) -> string name`

**Index2 summary:** `AbbrLocationStr(int sectorid) -> string name`

## Historical description

Get abbreviated sector name for sectorid

### Arguments named by the historical source

- number — sectorid — sectorid

### Returns named by the historical source

- string — name — shortened sector name

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`AbbrLocationStr(5000) -> "Sed H9"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_AbbrLocationStr) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
