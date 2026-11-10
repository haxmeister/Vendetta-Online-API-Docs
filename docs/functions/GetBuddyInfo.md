# GetBuddyInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetBuddyInfo(int char) -> string name, bool isonline, int sectorid`

## Historical description

Get name, online status and location of a buddy

### Arguments named by the historical source

- char charid of a buddy

### Returns named by the historical source

- name name of buddy
- isonline online status
- sectorid sectorid of location of buddy

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetBuddyInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
