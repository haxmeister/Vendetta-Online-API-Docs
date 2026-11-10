# SaveSystemNotes

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `SaveSystemNotes(string notes, int systemid) -> nil`

## Historical description

save system notes to settings/<charactername>/system<systemid>notes.txt Numbers longer then 14 digits shouldn't be used for systemid.

### Arguments named by the historical source

- notes Notes to save. Normally a spickled version of an API Index#SystemNotes entry, but it accepts anything
- sectorid systemid

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_SaveSystemNotes) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
