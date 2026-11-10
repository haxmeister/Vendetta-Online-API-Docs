# CanUseAddon

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `CanUseAddon( number itemid) -> boolean ret1, table {string l1 ...}`

**Index2 summary:** `CanUseAddon(int itemid) -> bool ret1, {string l1 ..}`

## Historical description

check if the player can equip the addon itemid

### Arguments named by the historical source

- number — itemid — itemid of addon to check

### Returns named by the historical source

- boolean — ret1 — can use
- table — {string l1 ...} — license requirements of the item at the current station (1-5) (only returned for local addons and...

### Other names in the historical table-return notation

`l1`, `ret1`

Racecar uses these as field labels in a table-shaped return description; the notation does **not establish that each is a string key**, or that the live return has the same layout.

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`CanUseAddon(12345) -> true {1, 2, 2, 2, 2}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_CanUseAddon) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
