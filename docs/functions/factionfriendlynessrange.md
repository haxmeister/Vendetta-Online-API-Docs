# factionfriendlynessrange

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `factionfriendlynessrange(int standing) -> float range`

## Historical description

get progress within the current faction standing level

### Arguments named by the historical source

- standing standing (0-65535)

### Returns named by the historical source

- float progress within faction standing level

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- a standing of 7000 is about halfway into "Hate" factionfriendlynessrange(7000) -> 0.534...`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_factionfriendlynessrange) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
