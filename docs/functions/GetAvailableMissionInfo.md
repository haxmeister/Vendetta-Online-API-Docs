# GetAvailableMissionInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetAvailableMissionInfo(int midx) -> {int itemtype, string name, bool active, int category, string icon, string desc}`

## Historical description

Returns information about the mission with the given index.

### Arguments named by the historical source

- midx index of mission in missionlist (1 based)

### Returns named by the historical source

- itemtype no idea
- name name of mission
- active is this mission active
- category mission category
- icon path to icon
- desc mission description

### Other names in the historical table-return notation

`active`, `category`, `desc`, `icon`, `itemtype`, `name`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetAvailableMissionInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
