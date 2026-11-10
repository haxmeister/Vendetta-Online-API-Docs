# GetSkirmishInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetSkirmishInfo() -> int crew1 crew2 init1 init2 string name1 name2 bool active`

## Historical description

returns crew info for skirmish missions

### Returns named by the historical source

- crew1 crew members left for side 1 (top bar)
- crew2 crew members left for side 2 (bottom bar)
- init1 initial crew strength for side 1
- init2 initial crew strength for side 2
- name1 name of side 1
- name2 name of side 2
- active true if mission active(?)

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetSkirmishInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
