# FindAndReplaceTagsCB

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `FindAndReplaceTagsCB(string text, function cb) -> string ret1`

## Historical description

Pass each occurances of with < and > enclosed substrings in text to cb and replace them with the return value

### Arguments named by the historical source

- test string to replace tags in
- cb called with the content of each tag as argument

### Returns named by the historical source

- ret1: converted text

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`local function find_cb(t) if t == "br" then return "\n" end end FindAndReplaceTags("hi this is a linebreak", find_cb) -> "hi this is a linebreak"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_FindAndReplaceTagsCB) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
