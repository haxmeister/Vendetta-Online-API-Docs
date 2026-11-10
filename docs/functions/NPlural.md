# NPlural

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `NPlural(string arg1, string arg2) -> string pstring`

## Historical description

concaterates the two provided strings together and pluralizes the result

### Arguments named by the historical source

- arg1 first substring
- arg2 second substring

### Returns named by the historical source

- pstring concaterated and pluralized string

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`NPlural("Serco", "Cookie") -> "Serco Cookies"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_NPlural) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
