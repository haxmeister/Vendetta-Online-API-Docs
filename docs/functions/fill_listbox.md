# fill_listbox

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `fill_listbox(userdata control, table itemlist, int curselindex, function setup_cb, bool show_quantity, show_price) -> table dialoglist`

## Historical description

fill a listbox with listsubdialogs according to given values

### Arguments named by the historical source

- control iup list to fill
- itemlist list of iteminfo
- curselindex index of current selection setup_cb function called for each item in itemlist. see: setup_cb
- click_cb function to after clicking on an item
- show_quantity show item quantity in list
- show_price show item price in list

### Returns named by the historical source

- dialoglist list of listsubdialog

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_fill_listbox) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
