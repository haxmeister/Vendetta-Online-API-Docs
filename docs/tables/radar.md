# radar

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

functions to query and set radar parameters

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `GetNearestObjectDistance` | `GetNearestObjectDistance() -> nil` | Get distance to the nearest "large" object. |
| `GetRadarSelectionID` | `GetRadarSelectionID() -> int nodeid objectid` | Get nodeid and objectid of targeted object |
| `HideRadar` | `HideRadar() -> nil` | Hide the radar. |
| `Hide3000mNavpoint` | `Hide3000mNavpoint() -> ?` | Not documented |
| `IsObjectOccluded` | `IsObjectOccluded() -> ?` | Not documented |
| `SetAimDirIcon` | `SetAimDirIcon() -> nil` | (Presumably) set the icon for hud_new_aimdir.png (mouselook reticle). |
| `SetAimDirIconColor` | `SetAimDirIconColor() -> nil` | Change the color of the mouselook reticle? |
| `SetAimDirIconSize` | `SetAimDirIconSize() -> nil` | (Presumably) change size of the mouselook reticle. |
| `SetDestArrows` | `SetDestArrows() -> nil` | (Presumably) change some aspect of the nav destination arrows on the HUD. |
| `SetHUDIcon` | `SetHUDIcon() -> ?` | Not documented |
| `SetNavDestinationArrowIconSize` | `SetNavDestinationArrowIconSize() -> nil` | Set the size of the arrows on the wormhole indicator on the HUD. |
| `SetNavpointFontHeight` | `SetNavpointFontHeight() -> nil` | (Presumably) change the size of the green + on the radar in ion storms. |
| `SetRadarSelection` | `SetRadarSelection(int nodeid , int objectid ) -> nil` | Change targets. |
| `SetRadarSelectionByPoint` | `SetRadarSelectionByPoint(float percentW, float percentH, string targetcommand) -> nil` | Change targets based on a given point on the screen and a specified targeting command. |
| `SetSelColor` | `SetSelColor(int r, g, b) -> nil` | Set targetbox color of the currently selected object. |
| `SetViewPort` | `SetViewPort() -> ?` | Not documented |
| `SetWormholeIconSize` | `SetWormholeIconSize() -> nil` | (Presumably) change the size of the wormhole icon on the radar. |
| `Show3000mNavpoint` | `Show3000mNavpoint() -> ?` | Not documented |
| `ShowRadar` | `ShowRadar() -> nil` | Show the radar. |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Radar)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
