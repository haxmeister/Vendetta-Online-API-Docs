# msgdlgtemplate1a

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `msgdlgtemplate1a(string msg, size, posx, posy, userdata control, string bgcolor) -> userdata dialog`

## Historical description

Create a dialog and optionally disable input to the background except to the given control. Note: if a control is given display the dialog with :show_all() if not use ShowDialog or :show()

### Arguments named by the historical source

- msg dialog message
- size iup size of dialog
- posx iup horizontal position
- posy iup vertical position
- control control to unmask
- bgcolor iup background color

### Returns named by the historical source

- dialog message dialog

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- with unmasked control -- run from station menu local d = msgdlgtemplate1aNext("bla", "200x200", 10, 10, StationLaunchButton) d:show_all()`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_msgdlgtemplate1a) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
