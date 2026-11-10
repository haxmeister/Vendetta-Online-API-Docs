# GetActiveShipEnergy

**Status:** **Invoked in a live Vendetta Online client (November 8–9, 2026).**

## Observed return values

**Observed forms:** `(number, number)`  
**Real captured example:** `(167.31474304199, 0.66925895214081)`

Second value tracks current energy divided by 250 in the observed ship; the interpretation is provisional.

The [observed-getters survey](observed-getters.md) has additional examples and context. These live results take precedence over older descriptions.

## Historical Racecar signature

**Individual page:** `GetActiveShipEnergy() -> float eng fraction`

## Historical description

returns the energy level of the active ship

### Returns named by the historical source

- eng energy level in game units 0 .. maxcapacacity
- fraction energy level as float from 0.0-1.0

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetActiveShipEnergy() -> 150.0 0.5`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveShipEnergy) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
