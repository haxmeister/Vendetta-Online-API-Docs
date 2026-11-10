# ConfigureWeaponGroup

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ConfigureWeaponGroup( number id, table port_ids [, function cb ]) -> nil`

**Index2 summary:** `ConfigureWeaponGroup(int id, table port_ids, function cb) -> nil`

## Historical description

Configures one weapon group

### Arguments named by the historical source

- number — id — number of group. 0-5 primary, 6-11 secondary and 12-17 tertiary trigger
- table — port_ids — list of ports active for that group (2-numweaponports)
- function — cb — function to call on completion (optional)

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ConfigureWeaponGroup) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
