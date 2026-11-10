# GetStationLocation

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationLocation(int stationid1) -> int stationid2`

## Historical description

get the stationid of the current station

### Arguments named by the historical source

- stationid1 optional stationid of a station

### Returns named by the historical source

- stationid2 stationid, nil if not docked to a station or stationid1 it is non nil

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationLocation) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
