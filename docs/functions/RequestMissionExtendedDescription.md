# RequestMissionExtendedDescription

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `RequestMissionExtendedDescription(string missionid, int stationid) -> bool`

## Historical description

Request the extended description of the given mission. Result is received via the Eventtype#MISSION_QUESTION_OPEN event. Calling this function does not open any gui screens.

### Arguments named by the historical source

- missionid string mission id (so "1234" not 1234)
- stationid int station id

### Returns named by the historical source

- boolean of unknown purpose

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_RequestMissionExtendedDescription) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
