# Game

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

functions to control a few game features ..

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `DisableInput` | `DisableInput() -> ?` | Not documented |
| `EnableInput` | `EnableInput()` | Not documented |
| `EndPlayback` | `EndPlayback() -> ?` | Not documented |
| `GetClientBuildNumber` | `GetClientBuildNumber() -> ?` | Not documented |
| `GetClientVersion` | `GetClientVersion() -> ?` | Not documented |
| `GetCommandForBind` | `GetCommandForBind() -> ?` | Not documented |
| `GetCVar` | `GetCVar(string name) -> result` | Returns the value of a C variable(?) I'm assuming that the term CVar refers to an ingame variable not directly accessible by Lua |
| `GetDesiredSpeed` | `GetDesiredSpeed() -> ?` | Not documented |
| `GetFlightMode` | `GetFlightMode() -> boolean` | Whether flight-assist mode is active |
| `GetMaxFramerate` | `GetMaxFramerate() -> ?` | Not documented |
| `GetNFZMode` | `GetNFZMode() -> ?` | Not documented |
| `GetObjectAtScreenPos` | `GetObjectAtScreenPos(float x, y) -> int nodeid , objectid` | Returns nodeid and objectid of a targetable object at specified screen coordinates |
| `GetScreenSize` | *Not specified* | Not documented |
| `GetTurretHealth` | `GetTurretHealth() -> ?` | Not documented |
| `GetTurretObjectID` | `GetTurretObjectID() -> ?` | Not documented |
| `IsInstalledFromMarket` | `IsInstalledFromMarket() -> ?` | Not documented |
| `IsMobiHandServiceInstalled` | `IsMobiHandServiceInstalled() -> ?` | Not documented |
| `OpenWebBrowser` | `OpenWebBrowser(string link) -> ?` | Not documented |
| `PerformGoogleBilling` | `PerformGoogleBilling() -> ?` | Not documented |
| `PerformMobiBilling` | `PerformMobiBilling() -> ?` | Not documented |
| `Quit` | `Quit()` | Not documented |
| `SetCVar` | `SetCVar(string name, string value) -> ?` | Not documented |
| `SetDesiredSpeed` | `SetDesiredSpeed() -> ?` | Not documented |
| `SetInputMode` | `SetInputMode() -> ?` | Not documented |
| `SetJumpDest` | `SetJumpDest( sectorid )` | Not documented |
| `SetMaxFramerate` | `SetMaxFramerate() -> ?` | Not documented |
| `StartLoginCinematic` | `StartLoginCinematic()` | Not documented |
| `StartPlayback` | `StartPlayback() -> ?` | Not documented |
| `StartRecording` | `StartRecording() -> ?` | Not documented |
| `StopLoginCinematic` | `StopLoginCinematic()` | Not documented |
| `StopRecording` | `StopRecording() -> ?` | Not documented |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Game)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
