# GetPlayerFactionStanding

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetPlayerFactionStanding(int factionid, charid) -> int standing`

## Historical description

get a players standing with a faction

### Arguments named by the historical source

- factionid a number representing a faction. All faction numbers, 1-13, will work for other players. factionid
- charid charid of a player (in the current sector?). nil is equivalent of own id.

### Returns named by the historical source

- standing number representing faction standing 0-65535, (0 in-game being -1000, 32768 in-game being 0 and 65535 being 1000 in-game)

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`print( GetPlayerFactionStanding(1) ) -> "32768"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetPlayerFactionStanding) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
