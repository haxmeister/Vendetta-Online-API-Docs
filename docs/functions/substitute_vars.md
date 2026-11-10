# substitute_vars

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `substitute_vars(string in) -> string out`

## Historical description

replace variables like: %target% %hailmsg% %sector% = ShortLocationStr(GetCurrentSectorid() or 1) %lastprivate% = GetLastPrivateSpeaker() in 'string in'

### Arguments named by the historical source

- int input string

### Returns named by the historical source

- out output string

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_substitute_vars) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
