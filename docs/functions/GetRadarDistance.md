# GetRadarDistance

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetRadarDistance(int charid) -> float distance`

## Historical description

get distance to another character visible through radar, including shared group radar

### Arguments named by the historical source

- charid character id of another character in this sector

### Returns named by the historical source

- distance distance to character in meters OR false if character is not within radar range

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetRadarDistance) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
