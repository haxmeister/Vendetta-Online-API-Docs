# JettisonMultiple

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `JettisonMultiple{item1 = {int id, int quantity} ..} -> nil`

## Historical description

Jettison cargo items and quantitiss according to the provided table

### Arguments named by the historical source

- item1 table containing quantity and itemid of cargo to jettison id itemid of cargo item quantity amount of this cargo to jettison

### Named table members in the historical signature

`item1`

These member names come from the historical return/argument notation; **their current presence and types have not been verified**.

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`JettisonMultiple{{id=1234, quantity=2}, {id=1235, quantity=3}}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_JettisonMultiple) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
