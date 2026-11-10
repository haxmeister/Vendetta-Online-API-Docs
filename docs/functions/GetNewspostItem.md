# GetNewspostItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetNewspostItem(int index) -> int id, time, string subject, bool important`

## Historical description

Get news post info

### Arguments named by the historical source

- index index of news post (1 to GetNumNewsPosts)

### Returns named by the historical source

- id id of news item
- time date of news item
- subject subject line
- important important flag

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetNewspostItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
