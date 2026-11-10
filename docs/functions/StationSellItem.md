# StationSellItem

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `StationSellItem(userdata button, table item, int quantity, function cb) -> nil`

## Historical description

Sell items with aconfirmation dialog

### Arguments named by the historical source

- button button that clalled this function. it will be activated if sale failed
- item iteminfo
- quantity how many units to sell cb optional function to call when done. an error code is passed to it

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_StationSellItem) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
