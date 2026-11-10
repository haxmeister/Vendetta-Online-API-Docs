# GetActiveMissionInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetActiveMissionInfo(int num) -> string mname table mmsg int itemid table mobj`

**Index2 summary:** `GetActiveMissionInfo(int num) -> string mname table mmsg int itemid`

## Historical description

Get information about the selcted active mission

### Arguments named by the historical source

- num index of active mission (always 1)

### Returns named by the historical source

- mname string containing name of active mission
- mmsg array where each index contains a mission log entry + optional interface elements and their properties
- itemid itemid of the mission
- mobj array where each index contains a mission objective

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetActiveMissionInfo(1) -> "awesome mission" {1={"awesome mission question" 2={0="button" 1="awesome button text" action=1}}} 1234 \ {1={"objective 1"}, 2={"objective 2"}, ... , n={"objective n"}}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveMissionInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
