# GetActiveShipName

**Status:** **Invoked in a live Vendetta Online client (November 8–9, 2026).**

## Observed return values

**Observed forms:** `(string)`; `nil` seen during ship transition  
**Real captured example:** `"EC-89"`

A transition callback captured nil, not documented by the old unqualified string claim.

The [observed-getters survey](observed-getters.md) has additional examples and context. These live results take precedence over older descriptions.

## Historical Racecar signature

**Individual page:** `GetActiveShipName() -> string name`

## Historical description

returns a string with the active ships name

### Returns named by the historical source

- name ...

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveShipName) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
