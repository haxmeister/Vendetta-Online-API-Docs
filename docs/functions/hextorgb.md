# hextorgb

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `hextorgb(string hexcolors) -> string deccolors`

## Historical description

Convert hexadecimal formated color string into a decimal one used by iup

### Arguments named by the historical source

- hexcolors hexadecimal color string

### Returns named by the historical source

- deccolors decimal color string

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`hextorgb("ff00ff") -> "255 0 255"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_hextorgb) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
