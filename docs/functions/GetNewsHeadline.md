# GetNewsHeadline

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetNewsHeadline(int index) -> string title int time ret1`

## Historical description

get headline, post time and some number

### Arguments named by the historical source

- index index of headline newest is 1

### Returns named by the historical source

- title the headline time post date in unix time ret1 no clue, always 1

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetNewsHeadline) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
