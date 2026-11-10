# SHA1

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `SHA1(string text) -> string hash`

## Historical description

generate SHA1 hash of the given string

### Arguments named by the historical source

- text text to hash

### Returns named by the historical source

- hash hash of text

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`SHA1("hi there!") -> "a903cda4b5b93d3204af0fd6b7b92d24af1923a5"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_SHA1) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
