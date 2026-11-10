# RegisterEvent

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `RegisterEvent(object eventhandler, string eventtype) -> nil`

## Historical description

Hook up object to event. The object is a function or a table with a method called OnEvent or the name of the event. See Event Intro

### Arguments named by the historical source

- eventhandler object or function to register with event
- eventtype eventtype

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_RegisterEvent) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
