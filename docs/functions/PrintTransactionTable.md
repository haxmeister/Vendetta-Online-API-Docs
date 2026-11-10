# PrintTransactionTable

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `PrintTransactionTable() -> nil`

## Historical description

print pending transactions.

### Returns named by the historical source

- {[x]={trackback="...(tail call): ?", wantcount=0, count=0}} for current transactions, otherwise returns nil.

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_PrintTransactionTable) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
