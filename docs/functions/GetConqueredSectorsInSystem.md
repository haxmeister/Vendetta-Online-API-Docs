# GetConqueredSectorsInSystem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetConqueredSectorsInSystem(int systemid) -> table sectors`

## Historical description

Get table with conquered sectors in the given system

### Arguments named by the historical source

- systemid systemid

### Returns named by the historical source

- sectors table with sectorid-factionid mappings or nil if no conquered sectors exist in system

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetConqueredSectorsInSystem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
