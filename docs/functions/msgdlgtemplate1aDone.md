# msgdlgtemplate1aDone

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `msgdlgtemplate1aDone(function button_cb, string msg, size, posx, posy, userdata control, string bgcolor) -> userdata dialog`

## Historical description

Same as msgdlgtemplate1a but with a "Close" button

### Arguments named by the historical source

- nutton_cb function called on clicking "Close"
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

`local d local function button_cb() HideDialog(d) end -- with unmasked control d = msgdlgtemplate1aDone(button_cb, "bla", "200x200", 10, 10, StationLaunchButton) d:show_all() -- without unmasked control -- local d = msgdlgtempla...`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_msgdlgtemplate1aDone) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
