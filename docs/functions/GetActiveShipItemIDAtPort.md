# GetActiveShipItemIDAtPort

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetActiveShipItemIDAtPort(int portid) -> int itemid`

## Historical description

returns itemid of addon in selected port

### Arguments named by the historical source

- portid portid

### Returns named by the historical source

- itemid itemid of addon in port

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetActiveShipItemIDAtPort(1) -> 1234`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveShipItemIDAtPort) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
