# Function probe — 2026-11-08

**Capture:** `20261108T204649.599089Z-22462-000001.txt`  
**Format:** `api-probe-v1`  
**Source:** `curated-candidates`  
**Candidates:** 22

These are observed Lua value types, **not verified function signatures**.
The probe reads selected names without calling them. It is not an exhaustive
inventory and does not distinguish the game's built-in API from names exposed
by installed plugins. The capture itself does not encode the VO API version.

| Name | Observation |
| --- | --- |
| `GetCharInfo` | inaccessible |
| `GetCurrentCharId` | inaccessible |
| `GetCurrentSectorid` | function |
| `GetCurrentStationid` | inaccessible |
| `GetCurrentSystemid` | function |
| `GetInventoryItemInfo` | function |
| `GetInventoryItemName` | function |
| `GetPlayerID` | inaccessible |
| `GetPlayerName` | function |
| `GetSectorName` | inaccessible |
| `GetTargetInfo` | function |
| `LoadSystemNotes` | function |
| `PlayerInventoryPairs` | function |
| `ProcessEvent` | function |
| `RegisterEvent` | function |
| `RegisterUserCommand` | function |
| `ReloadInterface` | function |
| `SaveSystemNotes` | function |
| `TCPSocket` | table |
| `UnregisterEvent` | function |
| `iup` | table |
| `rmlui` | userdata |

**Summary:** 14 functions, 2 tables, 1 userdata, 5 inaccessible.

An `inaccessible` result means the protected read raised an error. It
does not prove the function is absent; the name may be unavailable,
restricted, or incorrect. Actual parameters, return values, and behavior
must be established through separate controlled observations.

**Next:** Import candidate function names from documented API references,
then test their exposure without invoking the functions.
