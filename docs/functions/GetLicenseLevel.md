# GetLicenseLevel

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetLicenseLevel(int type, int charid) -> int level`

**Index2 summary:** `GetLicenseLevel(int type) -> int level`

## Historical description

get the level of the provided license. returns your own level if charid is not given.

### Arguments named by the historical source

- type type of license (1-5)
- charid character id or nil

### Returns named by the historical source

- level license level or 0 if invalid type given

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetLicenseLevel) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
