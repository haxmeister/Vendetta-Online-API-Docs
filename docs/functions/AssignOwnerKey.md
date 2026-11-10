# AssignOwnerKey

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `AssignOwnerKey( string keyid) -> nil nil`

**Index2 summary:** `AssignOwnerKey(string keyid) -> nil`

## Historical description

Assign an owner key to this station.

### Arguments named by the historical source

- string — keyid — key id. if nil a new key is created

### Returns named by the historical source

- nil — nil

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_AssignOwnerKey) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
