# TabCompleteName

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `TabCompleteName(string name) -> string completename`

## Historical description

Attempts to fill out name with the best match the client has seen since startup. If TabCompleteName cannot find a match for name it returns nil, otherwise, completename will be a string containing the best match.

### Arguments named by the historical source

- name name to be completed

### Returns named by the historical source

- completename completed name

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_TabCompleteName) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
