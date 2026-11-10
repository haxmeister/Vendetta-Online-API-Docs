# GetStationName

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetStationName(int stationid) -> string name`

## Historical description

Get the name of a station. If the provided stationid is invalid the function produces a lua error.

### Arguments named by the historical source

- stationid stationid or nil for the current station

### Returns named by the historical source

- name Long name of the current station if no argument is given, otherwise the sector name and coordinates of a station.

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetStationName(200*256+1) --returns "Sol II H-13" (200 is the sectorid for Sol II, H-13) GetStationName() -- returns "SkyCommand" when in the station at Sol II, H-13`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetStationName) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
