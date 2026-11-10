# NavRoute

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

functions to manipulate your NavRoute

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `add` | `add() -> ?` | Not documented |
| `addbyid` | `addbyid(int sectorid ) -> true` | Add a waypoint to the navigation route. sectorid equal or lower than 0 generates an error. |
| `clear` | `clear() -> Clear the current route` | Will clear any route if one exists |
| `GetCurrentRoute` | `GetCurrentRoute() -> table route` | Returns current nav route. Note: The return value is a reference to the navroute not a copy. That means the returned table is updated as the route chang... |
| `GetFinalDestination` | `GetFinalDestination() -> ?` | Not documented |
| `GetNextHop` | `GetNextHop() -> ?` | Not documented |
| `list` | `list() -> ?` | Not documented |
| `load` | `load() -> ?` | Not documented |
| `OnEvent` | `OnEvent() -> ?` | Not documented |
| `save` | `save() -> ?` | Not documented |
| `SetFinalDestination` | `SetFinalDestination(int destination) -> nil` | Plot navroute to specified sector. |
| `SetFullRoute` | `SetFullRoute(table route) -> nil` | Set the navigation route by specifying all it's points. |
| `undo` | `undo() -> ?` | Not documented |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/NavRoute)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
