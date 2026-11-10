# UpdateRadarFriendlyStatus

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `UpdateRadarFriendlyStatus(int nodeid) -> nil`

## Historical description

update the radar with the new status when overriding the GetFriendlyStatus function

### Arguments named by the historical source

- nodeid node id of one of the characters in the sector

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_UpdateRadarFriendlyStatus) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
