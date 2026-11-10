# FindAndReplaceTags

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `FindAndReplaceTags(string text, table matches) -> string ret1`

## Historical description

Replaces all occurances of with < and > enclosed substrings in text with matching values from the provided table

### Arguments named by the historical source

- test string to replace tags in
- matches table with tags/replacement pairs

### Returns named by the historical source

- ret1: converted text

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`FindAndReplaceTags("hi this is a linebreak", {br="\n"}) -> "hi this is a linebreak"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_FindAndReplaceTags) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
