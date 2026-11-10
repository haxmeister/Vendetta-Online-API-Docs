# rgbtohex

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `rgbtohex(string deccolor) -> string hexcolor`

## Historical description

Returns string containing escaped hexadecimal version of the in decimal given color

### Arguments named by the historical source

- deccolor string with color in decimal format (format: "r g b")

### Returns named by the historical source

- hexcolor string starting with ascii code 127 followed by the color in hexadecimal format. (format: '\127RRGGBB') on failure it returns your input value

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`print(rgbtohex("255 0 0").."hi!")`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_rgbtohex) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
