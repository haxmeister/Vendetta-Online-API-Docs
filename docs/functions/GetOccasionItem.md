# GetOccasionItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetOccasionItem(int index) -> int id, time, duration, string name, bool important, int timestamp`

## Historical description

Get occasion (event) info

### Arguments named by the historical source

- index index of event (1 to GetNumOccasions)

### Returns named by the historical source

- id id of news item
- time time when the event takes place
- duration duration of event
- name name of event
- important important flag
- timestamp time of posting

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetOccasionItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
