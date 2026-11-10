# Keychain

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

keychain management

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `revokekey` | `revokekey( name , keyid ) -> ?` | Revokes a key from the specified character name. If you specify an owner keyid, for someone who only has the paired user keyid, the user key will be rem... |
| `list` | `list([ keyid ]) -> nil` | Prints a list of keys on your keychain to the chat window or opens the key management window if a keyid is specified |
| `giveuserkey` | `giveuserkey( name , keyid ) -> ?` | Not documented |
| `changedescription` | `changedescription( keyid ,` | ( keyid , description ) Description: |
| `setaccess` | *Not specified* | Not documented |
| `giveownerkey` | *Not specified* | Not documented |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Keychain)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
