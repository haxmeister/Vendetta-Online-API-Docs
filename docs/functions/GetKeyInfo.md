# GetKeyInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetKeyInfo(int keyindex) -> string keyid, string desc`

## Historical description

Get information about the key with the given index in the keychain

### Arguments named by the historical source

- keyindex index of key (1 to GetNumKeysInKeychain)

### Returns named by the historical source

- keyid key id
- desc description of key
- ownerid key id of the associated owner key or false
- time
- unknown
- unknown
- isactive is the key active?

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetKeyInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
