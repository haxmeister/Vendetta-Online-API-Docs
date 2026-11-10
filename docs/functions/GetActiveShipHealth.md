# GetActiveShipHealth

**Status:** **Invoked in a live Vendetta Online client (November 8–9, 2026).**

## Observed return values

**Observed forms:** `(number × 8, nil, nil)` when active; zero return values in a transition  
**Real captured example:** `(25, 0, 0, 0, 0, 0, 25, 6000, nil, nil)`

Historical detailed page also describes positions 9–10 as shield values; both were nil in the observed ship. Older Index2 summary listed only eight positions.

The [observed-getters survey](observed-getters.md) has additional examples and context. These live results take precedence over older descriptions.

## Historical Racecar signature

**Individual page:** `GetActiveShipHealth() -> int d1 d2 d3 d4 d5 d6 dmg max shields shields_max`

**Index2 summary:** `GetActiveShipHealth() -> int d1 d2 d3 d4 d5 d6 dmg max`

## Historical description

returns information about the active ships health

### Returns named by the historical source

- d? damage to subsection 0 = no damage
- dmg accumulated damage of subsections
- max max health of ship
- shields current value of ship shields (nil if doesn't have shields)
- shields_max max value of ship shields (nil if doesn't have shields)

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetActiveShipHealth() -> 500 10 10 0 0 0 520 1000000 30000 40000`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveShipHealth) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
