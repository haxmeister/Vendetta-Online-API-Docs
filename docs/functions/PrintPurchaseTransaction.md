# PrintPurchaseTransaction

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `PrintPurchaseTransaction(string name, int quantity, totalvalue, totalcost) -> nil`

## Historical description

Print a sale summery message to the chat log

### Arguments named by the historical source

- name sold item
- quantity number items sold
- totalvalue value of items
- totalcost price of items

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- prints "100x of Stuff sold for a total amount of 1000c (profit of 1c)" to the chat log PrintPurchaseTransaction("Stuff", 100, 1000, 999)`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_PrintPurchaseTransaction) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
