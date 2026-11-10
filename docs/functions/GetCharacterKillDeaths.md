# GetCharacterKillDeaths

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetCharacterKillDeaths(int charid) -> int kills deaths pks`

## Historical description

get info about kills and deaths. returns your own info if no charid given or a lua error if an invalid one ...

### Arguments named by the historical source

- charid character id or nil

### Returns named by the historical source

- kills total kills deaths total deaths pks player kills

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetCharacterKillDeaths) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
