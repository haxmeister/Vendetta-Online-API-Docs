# RequestMissionDetails

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `RequestMissionDetails(int missionid) -> nil`

## Historical description

Request information about the given mission (aka the info button) and pop up API_Index#MissionPromptDialog if id is valid

### Arguments named by the historical source

- missionid mission id (1-n)

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_RequestMissionDetails) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
