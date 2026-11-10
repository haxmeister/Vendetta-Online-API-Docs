# GetCurrentStationID

**Status:** **Invoked in a live Vendetta Online client (November 8–9, 2026).**

## Observed return values

**Observed forms:** `(number)` or `(nil)`  
**Real captured example:** `1432833` when docked; `nil` when undocked

Historic index lists only an integer; the live function can return nil.

The [observed-getters survey](observed-getters.md) has additional examples and context. These live results take precedence over older descriptions.

## Historical Racecar signature

**Index2 summary:** `GetCurrentStationID() -> int stationid`

## Historical description

get current station id

## Evidence and limitations

- [Racecar Index2](https://www.vo-wiki.com/racecar2/index.php/API_Index2); no individual page present in the supplied archive.
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
