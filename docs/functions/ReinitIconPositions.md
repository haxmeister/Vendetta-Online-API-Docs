# ReinitIconPositions

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ReinitIconPositions(timer icontimer, int ship, userdata viewport, table iconlist, userdata iconcontainer, table ipcache) -> nil`

## Historical description

Setup icons in a viewport

### Arguments named by the historical source

- icontimer timer for overlap prevention animation
- ship itemid of ship to use
- viewport target viewport
- iconlist table to portdata to portids
- iconcontainer target box
- ipcache table that maps icon_positions to ship types that acts as a cache

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ReinitIconPositions) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
