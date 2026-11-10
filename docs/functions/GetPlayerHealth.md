# GetPlayerHealth

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetPlayerHealth(int charid) -> float health shields`

**Index2 summary:** `GetPlayerHealth(int charid) -> float health`

## Historical description

get health of provided character

### Arguments named by the historical source

- charid character id

### Returns named by the historical source

- health health of character in percent or -1 if character is not in the current sector
- shields shields of character in percent or nil if doesn't have shields

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetPlayerHealth) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
