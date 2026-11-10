# GeneratePlayerDiedMessage

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GeneratePlayerDiedMessage(string name1, name2, int weapon) -> string msg`

## Historical description

generate appropiate kill message for the arguments.

### Arguments named by the historical source

- name1 character that died
- name2 character that killed name1
- weapon weaponid of weapon with which the kill was made(?)

### Returns named by the historical source

- msg kill message

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GeneratePlayerDiedMessage("foo", "bar", 0) -> "bar destroyed foo" GeneratePlayerDiedMessage("foo", "foo", 0) -> "foo is having issues"`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GeneratePlayerDiedMessage) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
