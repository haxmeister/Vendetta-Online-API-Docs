# comma_value

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `comma_value(float number) -> string formatted_number`

## Historical description

returns a formatted version of the provided number according to API_Index#SI_unit

### Arguments named by the historical source

- number: unformatted number

### Returns named by the historical source

- formatted_number formatted number

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`comma_value(1000.00) -> "1,000.00"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_comma_value) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
