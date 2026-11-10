# PurchaseShipLoadout

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `PurchaseShipLoadout(function buybackdone_cb(boolean success), loadout) -> nil`

## Historical description

Buys ship presets as stored in ShipPresets table. Also sets weapon groups.

### Arguments named by the historical source

- buybackdone_cb(boolean success) callback function that gets called when transation finished, takes one argument which is true in case of success false otherwise.
- loadout loadout as stored in ShipPresets table.

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`PurchaseShipLoadout(function(success) print(success) end, ShipPresets[1])`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_PurchaseShipLoadout) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
