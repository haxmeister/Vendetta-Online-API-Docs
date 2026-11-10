# navmenu_template

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `navmenu_template(bool showjumpbutton, function close_cb, bool issubsub) -> userdata container, distancetext, jumpbutton, zoombutton, undolastbutton`

## Historical description

Create a control with a navmenu description box and some control buttons

### Arguments named by the historical source

- showjumpbutton show the jump button if true
- close_cb function to call after clicking the jump button while the player is able to jump
- issubsub create a sub sub tab

### Returns named by the historical source

- container navmenu_template
- distancetext distance label
- jumpbutton jump button or nil
- zoombutton zoom button
- undolastbutton undo button

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_navmenu_template) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
