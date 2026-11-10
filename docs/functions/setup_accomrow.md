# setup_accomrow

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `setup_accomrow(int index, table itemlist, userdata subdlg, function click_cb) -> int newindex`

## Historical description

Initializes a list item in an accomplishment list. (used as setup_cb argument of fill_accomlistbox)

### Arguments named by the historical source

- index position within itemlist
- itemlist see itemlist
- subdialog an itemlist dialog
- click_cb function called after clicking on subdialog

### Returns named by the historical source

- newindex position within itemlist + items consumed

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_setup_accomrow) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
