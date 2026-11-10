# create_char_inventory_tab

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `create_char_guild_tab(bool expand_local_branches, show_prices, showsellbutton) -> userdata box, tree`

## Historical description

Create inventory tab

### Arguments named by the historical source

- expand_local_branches expand the "Local Inventory" branch by default
- show_prices show item prices while docked to station
- showsellbutton show a sell button. the sell button is inactive unless show_pricess is set

### Returns named by the historical source

- box CharInventoryTab
- tree the tree control in the tab

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_create_char_inventory_tab) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
