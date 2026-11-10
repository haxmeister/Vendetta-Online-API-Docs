# ConfigureMultipleWeaponGroups

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ConfigureMultipleWeaponGroups( table [, function cb ]) -> nil`

**Index2 summary:** `ConfigureMultipleWeaponGroups({table group1key1, table group1key2 ... table group1key6, table group2key1, table group2key2...}, function cb) -> nil`

## Historical description

configures weapon groups according to given tables.

### Arguments named by the historical source

- table — {table group1key1, table group1key2 ... table group1key6, table group2key1, table group2key2...}
- group*key* Each table represents one group key. Key 1-6 map to the primary trigger, 7-12 secondary and 13-18 tertiary. Each index in the tables represents a port. Weapon ports start at in...
- function — cb — function to call on completion (optional)

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ConfigureMultipleWeaponGroups) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
