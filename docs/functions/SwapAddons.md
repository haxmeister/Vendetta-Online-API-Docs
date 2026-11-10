# SwapAddons

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `SwapAddons(int portid1 itemid1 porid1 itemid2 function cb) -> nil`

## Historical description

Swap two addons equipped to the current ship (crashes client after undocking)

### Arguments named by the historical source

- portid1 port of first item
- itemid1 itemid of addon that is supposed to go into port with id portid1
- portid2 port of second item
- itemid2 itemid of addon that is supposed to go into port with id portid2
- cb function to call on success

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`SwapAddons(2, 1234, 3, 1235)`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_SwapAddons) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
