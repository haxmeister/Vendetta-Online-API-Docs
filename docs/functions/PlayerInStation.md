# PlayerInStation

**Status:** **Invoked in a live Vendetta Online client (November 8–9, 2026).**

## Observed return values

**Observed forms:** `(boolean)`  
**Real captured example:** `true` docked, `false` in space

Observed values agree with station context.

The [observed-getters survey](observed-getters.md) has additional examples and context. These live results take precedence over older descriptions.

## Historical Racecar signature

**Individual page:** `PlayerInStation() -> bool instation`

## Historical description

Tell if player is docked.

### Returns named by the historical source

- instation true if the player is docked, otherwise false

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_PlayerInStation) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
