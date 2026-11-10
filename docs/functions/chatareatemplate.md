# chatareatemplate

**Status:** Legacy Racecar individual page; absent from newer Index2 listing; current availability unverified.

## Historical Racecar signature

**Individual page:** `chatareatemplate(string statontabname, bool expanded) -> table container`

## Historical description

create old style chatarea that combines general, mission and station log. the container seems to be incompatible with the chatareatemplate2 based maximized chat containers which breaks the maximize button

### Arguments named by the historical source

- stationtabnaem "Station", "ShipCom" or nil. determines which maximized chat container to show on clicking the maximize button and whether to show the station log
- expanded create a maximized chat container

### Returns named by the historical source

- container chat container
- container.area the chat area box
- container.chatlog ChatLogTemplate for the general chat
- container.missionlog ChatLogTemplate for the mission log
- container.stationlog optional ChatLogTemplate for the station log
- container.setup setup the chatarea

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_chatareatemplate) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
