# FadeLookup

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `FadeLookup(userdata control) -> table fi`

## Historical description

Get a fade info table of a control that is currently being faded.

### Arguments named by the historical source

- control faded iup control

### Returns named by the historical source

- fi fade info table or nil if the given control isn't currently being faded
- fi.timetofade time to fade in seconds
- fi.startalpha alpha value before fading (0-1)
- fi.endalpha alpha value after fading(0-1)
- fi.endfunc function to call when done
- fi.endfuncargs table with arguments for fi.endfunc
- fi.counter elapsed fade time
- fi.control control that is being faded

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_FadeLookup) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
