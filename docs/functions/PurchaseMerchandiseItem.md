# PurchaseMerchandiseItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `PurchaseMerchandiseItem(int itemid, int amount, func callback) -> nil`

**Index2 summary:** `PurchaseMerchandiseItem(int itemid, int amount, function callback) -> nil`

## Historical description

buy the provided item

### Arguments named by the historical source

- itemid itemid of cargo merch item
- amount number of items to purchase
- callback function that gets called when transaction is finished, callback is called with no arguments in case of success or with numeric errorcode in case of failure

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_PurchaseMerchandiseItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
