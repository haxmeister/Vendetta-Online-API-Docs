# spickle

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `spickle(table intab) -> string`

## Historical description

Converts a table into a string roughly of the format "value","value",{"tablevalue","tablevalue";tablekey="value"};key="value",key="value"

### Arguments named by the historical source

- intab input table

### Returns named by the historical source

- The spickled string

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`spickle(blah) returns "string1",{},"string2";apple="orange",fulltable={3,4,"string3"}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_spickle) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
