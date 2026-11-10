# GetTargetInfo

**Status:** **Invoked in a live Vendetta Online client (November 8–9, 2026).**

## Observed return values

**Observed forms:** zero values with no target; seven values with asteroid or NPC target  
**Real captured example:** `("Asteroid", nil, 1186.8591428641, nil, nil, nil, nil)`

The historical detail page lists six fields; live callbacks returned seven positions, with the seventh nil in tested cases.

The [observed-getters survey](observed-getters.md) has additional examples and context. These live results take precedence over older descriptions.

## Historical Racecar signature

**Individual page:** `GetTargetInfo() -> string name, number health, number dist, number factionid, string guild, string ship`

**Index2 summary:** `GetTargetInfo() -> string name float health dist int factionid string guild ship`

## Historical description

get info about target

### Returns named by the historical source

- string — name
- number — health — health in percent
- number — dist — distance in meters
- number — factionid — faction of target
- string — guild — guild tag of target
- string — ship — name of targets ship

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetTargetInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
