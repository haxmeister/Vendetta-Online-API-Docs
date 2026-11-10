# ParseXML

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ParseXML(string xmlstring) -> {dom}`

## Historical description

returns the provided string as a collection of substrings and nodes as subtables ..see example

### Arguments named by the historical source

- xmlstring string containing xml tags

### Returns named by the historical source

- dom table with xml nodes and substrings

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`ParseXML("a <xml>test</xml>woohoo<tag>subtext<bla>subsubtext</bla></tag>") -> {"a ", {"test", "xml"}, "woohoo", {"subtext", {"subsubtext", "bla" }, "tag"}}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ParseXML) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
