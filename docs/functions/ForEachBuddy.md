# ForEachBuddy

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ForEachBuddy(function func(string name, bool isonline, int sectorid)) -> nil`

## Historical description

calls func with the name, if the player is online for each of your buddies as well as his position if the player is currently online

### Arguments named by the historical source

- func gets called for each buddy
- name name of the buddy
- isonline true if the player is online else false
- sectorid location of player as sectorid

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`ForEachBuddy(function (name, isonline, pos) print(name .." "..tostring(isonline).." "..tostring(pos)) end)`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ForEachBuddy) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
