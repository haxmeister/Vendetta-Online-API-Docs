# UnloadCargo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `UnloadCargo({{int itemid, int quantity} ..}, function cb) -> nil`

## Historical description

Unload cargo items and quantities according to the provided table

### Arguments named by the historical source

- itemid itemid of cargo item
- quantity amount of this cargo to unload
- cb optional function to call on success

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`UnloadCargo{{itemid=1234, quantity=2}, {itemid=1235, quantity=3}}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_UnloadCargo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
