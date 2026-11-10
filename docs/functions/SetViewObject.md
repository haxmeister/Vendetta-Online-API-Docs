# SetViewObject

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `SetViewObject(userdata modelview, string meshname, string meshfile, int color) -> nil`

## Historical description

Change the ship in a modelview

### Arguments named by the historical source

- modelview modelview to change
- meshname mesh name of ship
- meshfile filename of mesh
- color colorid

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_SetViewObject) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
