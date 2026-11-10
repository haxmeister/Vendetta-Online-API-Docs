# GetTurretNamesByStationType

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetTurretNamesByStationType(string stype) -> {string tur1 ..}`

## Historical description

get turret name of provided station type

### Arguments named by the historical source

- stype station type

### Returns named by the historical source

- tur1 turret name (2-n)(?)

### Other names in the historical table-return notation

`tur1`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetTurretNameByStationType("frigate") -> {2 = "LeftAft", 3 = "Left Front", 4 = "Left Lower Fin" ..}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetTurretNamesByStationType) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
