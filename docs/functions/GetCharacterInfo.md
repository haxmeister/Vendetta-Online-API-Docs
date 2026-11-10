# GetCharacterInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetCharacterInfo(int cslot) -> string name faction int money kills deaths loc home cl ll hl tl ml`

## Historical description

Get information about your characters

### Arguments named by the historical source

- cslot a character slot (1-6)

### Returns named by the historical source

- name
- faction
- money
- kills all kills
- deaths
- loc sectorid of current location
- home sectorid of characters homestation
- cl combat level
- ll light weapon level
- hl heavy weapon level
- tl trade level
- ml mining level

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetCharacterInfo(1) -> "Dude" "Corvus" 10000 10 100 4444 4444 1 1 1 0 0`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetCharacterInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
