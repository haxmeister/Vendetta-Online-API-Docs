# GetAccomplishmentLevels

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetAccomplishmentLevels(int accomid) -> int curlevel int reqlevel`

## Historical description

returns the current and the required level for the selected accomplishment

### Arguments named by the historical source

- accomid id of the accomplishment

### Returns named by the historical source

- curlevel current level of the accomplishment
- reqlevel what is required to get the accomplishment

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetAccomplishmentLevels(9) -> 34 50`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetAccomplishmentLevels) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
