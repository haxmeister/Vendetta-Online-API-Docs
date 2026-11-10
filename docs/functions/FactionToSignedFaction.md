# FactionToSignedFaction

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `FactionToSignedFaction(integer standing) -> integer`

**Index2 summary:** `FactionToSignedFaction(int faction) -> int`

## Historical description

Convert absolute faction standing values (0 to 65535) into signed faction standing values (-1000 to 1000)

### Arguments named by the historical source

- standing absolute (0 to 65535) faction standing value

### Returns named by the historical source

- Signed integer (-1000 to 1000) faction standing value, rounded down.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_FactionToSignedFaction) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
