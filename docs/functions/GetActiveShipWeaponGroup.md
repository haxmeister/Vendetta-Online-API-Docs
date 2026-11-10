# GetActiveShipWeaponGroup

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetActiveShipWeaponGroup(int id) -> table group`

## Historical description

return which ports are enabled in the provided group

### Arguments named by the historical source

- id id of weapon group correspondents to group key[0-5] + (trigger group[0-2] * 6)

### Returns named by the historical source

- port table where the indexes are the port ids and values bools that are true when the port is active

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetActiveShipWeaponGroup(6) -> {2=true 3=true}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveShipWeaponGroup) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
