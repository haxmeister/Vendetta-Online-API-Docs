# factionfriendlynesscolor

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `factionfriendlynesscolor(int standing) -> string color`

## Historical description

get iup color that represents that given faction standing

### Arguments named by the historical source

- standing standing (0-65535)

### Returns named by the historical source

- color iup color string

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`factionfriendlynesscolor(1000) -> "195 3 0"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_factionfriendlynesscolor) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
