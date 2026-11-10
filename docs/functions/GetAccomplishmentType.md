# GetAccomplishmentType

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetAccomplishmentType(int accomindex, char) -> int accomplishmenttype int accomplishmentlevel`

## Historical description

returns some numbers..

### Arguments named by the historical source

- accomindex index of the accomplishment
- char charid of character whose accomplishment to look up

### Returns named by the historical source

- accomplishmenttype type of accomplishment
- accomplishmentlevel what level the accomplishment is, starting at 1.

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`local accomtype, accomlevel = GetAccomplishmentType(accomindex) local description = GetAccomplishmentDescription(accomtype, accomlevel)`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetAccomplishmentType) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
