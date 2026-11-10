# FadeControl

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `FadeControl(userdata control, int timetofade, float startalpha, endalpha, function cb, ...) -> nil`

## Historical description

Fade an iup control by modifying its alpha field. Usually a label.

### Arguments named by the historical source

- control iup control to fade
- timetofade time to fade in seconds
- startalpha alpha value before fading (0-1)
- endalpha alpha value after fading(0-1)
- cb function to call when done
- ... arguments to pass to cb

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- shows a dialog with a label that will fade away on clicking "Fade" -- clicking on "Stop" interrupts the process local d, label, fadebutton, stopbutton label = iup.label{title="Fade me!"} local function fadebutton_cb() local...`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_FadeControl) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
