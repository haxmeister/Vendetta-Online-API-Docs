# Fourth live event survey — callback-time context (2026-11-09 UTC)

**Evidence:** One live `api-event-watch-v3` snapshot, `20261109T004719.408544Z-25087-000001.txt`.

The report contains **58 distinct event names**, **84 saved examples**, and **31 examples with getter context**, across **17 event names**. **One new event name**, `PLAYER_HOME_CHANGED`, brings cumulative live coverage to **69 of 214 historical candidates**.

The event occurrence counts are for this watch session, **not frequencies of each sample**. Snapshots store at most two examples per argument shape. Callback-time getter values may reflect an intermediate or already-updated game state. Matching numbers are correlations, not automatically confirmed semantic names.

## Strong correlations and counterexamples

- `SECTOR_CHANGED` callback arguments `4978` and `5823` exactly matched `GetCurrentSectorid()` at both sampled callbacks. The associated `GetCurrentSystemid()` values were `20` and `23`.
- `PLAYER_DIED` returned `(345929, 345929, 0, 4764)`. Getter context at the callback gave `GetCurrentSectorid() = 4764`, `PlayerInStation() = false`, and `HasActiveShip() = false`. Only one saved example.
- `STORM_STARTED` had no arguments and `IsStormPresent() = true`; two `STORM_STOPPED` samples had no arguments and `IsStormPresent() = false`.
- `ENTERING_STATION`, `ENTERED_STATION`, and `SHOW_STATION` had no arguments and sampled `PlayerInStation() = true` and `GetCurrentStationID() = 1219585`. `LEAVING_STATION` had no arguments and sampled `PlayerInStation() = false`, station ID `nil`.
- `TARGET_CHANGED` continued to have no arguments. Its contextual `GetTargetInfo()` third position and `GetTargetDistance()` first position matched: `3684.7738058122` and `1860.8920575896`.
- `TARGET_SCANNED` had `(string, 10, 99)` in the saved examples. Context distances were `3690.9697912608` and `4027.6685563735`, so **neither numeric event argument is the current target distance in these examples**.
- `NAVROUTE_CHANGED` included `table{[1]=4764}` while `GetCurrentSectorid()` returned `5076`; the sampled route number therefore did **not** equal the current sector ID. A separate empty-route table was seen at sector `4764`.
- `SHIP_CHANGED` sampled `HasActiveShip() = false`, `GetActiveShipName() = nil`, and `GetActiveShipHealth()` returning **zero values** for one numeric ID; another sampled `HasActiveShip() = true` and ten health return positions. These may represent different phases of ship transition.
- `MISSIONLIST_UPDATED` delivered explicit `nil` in both a station and an undocked context. An earlier batch observed the separate numeric form `3`; both signatures remain documented.
- `CINEMATIC_START` repeated all three observed forms: **zero arguments**, `(false)`, and `(4)` or `(6)`, while callback-time `PlayerInStation()` was false in these examples.
- `PLAYER_HOME_CHANGED` appeared for the first time with numeric argument `1219585`. A station ID with the same value appeared elsewhere in this session, but the aggregate snapshot does not establish simultaneity or identity of meaning.

## All captured event names

| Event | Callbacks | Saved examples | Observed argument signature(s) | Example | Context? |
| --- | ---: | ---: | --- | --- | --- |
| [`ACTIVATE_CHAT_CHANNEL`](ACTIVATE_CHAT_CHANNEL.md) | 4 | 1 | `0:` | Values redacted | — |
| [`CHAT_CANCELLED`](CHAT_CANCELLED.md) | 2 | 1 | `0:` | Values redacted | — |
| [`CHAT_DONE`](CHAT_DONE.md) | 3 | 1 | `0:` | Values redacted | — |
| [`CHAT_ENTERED`](CHAT_ENTERED.md) | 1 | 1 | `1:string` | Values redacted | — |
| [`CHAT_MSG_BARENTER`](CHAT_MSG_BARENTER.md) | 2 | 1 | `1:table` | Values redacted | — |
| [`CHAT_MSG_BARLIST`](CHAT_MSG_BARLIST.md) | 2 | 1 | `1:table` | Values redacted | — |
| [`CHAT_MSG_CHANNEL_ACTIVE`](CHAT_MSG_CHANNEL_ACTIVE.md) | 3 | 1 | `1:table` | Values redacted | — |
| [`CHAT_MSG_CONFIRMATION`](CHAT_MSG_CONFIRMATION.md) | 2 | 1 | `1:table` | Values redacted | — |
| [`CHAT_MSG_DEATH`](CHAT_MSG_DEATH.md) | 1 | 1 | `1:table` | Values redacted | — |
| [`CHAT_MSG_SECTORD_SECTOR`](CHAT_MSG_SECTORD_SECTOR.md) | 6 | 1 | `1:table` | Values redacted | — |
| [`CHAT_MSG_SERVER`](CHAT_MSG_SERVER.md) | 12 | 1 | `1:table` | Values redacted | — |
| [`CHAT_MSG_SERVER_SECTOR`](CHAT_MSG_SERVER_SECTOR.md) | 8 | 1 | `1:table` | Values redacted | — |
| [`CINEMATIC_START`](CINEMATIC_START.md) | 19 | 5 | `0:`, `1:boolean`, `1:number` | no arguments | Yes |
| [`COMMAND`](COMMAND.md) | 10 | 2 | `1:number`, `2:number,table` | Values redacted | — |
| [`CONQUERED_SECTORS_UPDATED`](CONQUERED_SECTORS_UPDATED.md) | 2 | 2 | `1:table` | table{[27]=true, [30]=true} | — |
| [`ENTER_ZONE_dock`](ENTER_ZONE_dock.md) | 1 | 1 | `1:string` | "dock" (bytes=4) | — |
| [`ENTER_ZONE_NFZ`](ENTER_ZONE_NFZ.md) | 3 | 1 | `1:string` | "NFZ" (bytes=3) | — |
| [`ENTER_ZONE_wormhole`](ENTER_ZONE_wormhole.md) | 6 | 1 | `1:string` | "wormhole" (bytes=8) | — |
| [`ENTERED_STATION`](ENTERED_STATION.md) | 2 | 1 | `0:` | no arguments | Yes |
| [`ENTERING_STATION`](ENTERING_STATION.md) | 2 | 1 | `0:` | no arguments | Yes |
| [`HUD_HIDE`](HUD_HIDE.md) | 21 | 1 | `0:` | no arguments | — |
| [`HUD_SHOW`](HUD_SHOW.md) | 10 | 1 | `1:string` | "ship" (bytes=4) | — |
| [`INVENTORY_ADD`](INVENTORY_ADD.md) | 4 | 2 | `1:number` | 14168 | — |
| [`INVENTORY_REMOVE`](INVENTORY_REMOVE.md) | 4 | 2 | `1:number` | 5867 | — |
| [`INVENTORY_UPDATE`](INVENTORY_UPDATE.md) | 6 | 2 | `1:number` | 14164 | — |
| [`LEAVE_ZONE_dock`](LEAVE_ZONE_dock.md) | 1 | 1 | `1:string` | "dock" (bytes=4) | — |
| [`LEAVE_ZONE_NFZ`](LEAVE_ZONE_NFZ.md) | 3 | 1 | `1:string` | "NFZ" (bytes=3) | — |
| [`LEAVE_ZONE_wormhole`](LEAVE_ZONE_wormhole.md) | 3 | 1 | `1:string` | "wormhole" (bytes=8) | — |
| [`LEAVING_STATION`](LEAVING_STATION.md) | 2 | 1 | `0:` | no arguments | Yes |
| [`MISSIONLIST_UPDATED`](MISSIONLIST_UPDATED.md) | 27 | 2 | `1:nil` | nil | Yes |
| [`MSG_LOGOFF_TIMER`](MSG_LOGOFF_TIMER.md) | 11 | 2 | `1:string` | "10 seconds to self-destruct." (bytes=28) | — |
| [`MSG_NOTIFICATION`](MSG_NOTIFICATION.md) | 13 | 2 | `4:string,number,boolean,boolean` | "Press the Activate key to enter wormhole to Latos." (bytes=50); 5000; false; false | — |
| [`NAVROUTE_CHANGED`](NAVROUTE_CHANGED.md) | 2 | 2 | `1:table` | table{[1]=4764} | Yes |
| [`PLAYER_DEATH_CINEMATIC_FINISHED`](PLAYER_DEATH_CINEMATIC_FINISHED.md) | 1 | 1 | `0:` | no arguments | — |
| [`PLAYER_DIED`](PLAYER_DIED.md) | 1 | 1 | `4:number,number,number,number` | 345929; 345929; 0; 4764 | Yes |
| [`PLAYER_ENTERED_SECTOR`](PLAYER_ENTERED_SECTOR.md) | 300 | 2 | `1:number` | 30460274 | — |
| [`PLAYER_GUILD_TAG_UPDATED`](PLAYER_GUILD_TAG_UPDATED.md) | 2 | 2 | `1:number` | 30460008 | — |
| [`PLAYER_HOME_CHANGED`](PLAYER_HOME_CHANGED.md) | 1 | 1 | `1:number` | 1219585 | — |
| [`PLAYER_LEFT_SECTOR`](PLAYER_LEFT_SECTOR.md) | 272 | 2 | `1:number` | 1000088352 | — |
| [`PLAYER_STATS_UPDATED`](PLAYER_STATS_UPDATED.md) | 8 | 1 | `1:number` | 345929 | — |
| [`PLAYER_UPDATE`](PLAYER_UPDATE.md) | 19 | 1 | `1:number` | 345929 | — |
| [`PLAYER_UPDATE_STATS`](PLAYER_UPDATE_STATS.md) | 11 | 1 | `1:number` | 345929 | — |
| [`SECTOR_CHANGED`](SECTOR_CHANGED.md) | 8 | 2 | `1:number` | 4978 | Yes |
| [`SECTOR_LOADED`](SECTOR_LOADED.md) | 8 | 2 | `0:` | no arguments | Yes |
| [`SHIP_CHANGED`](SHIP_CHANGED.md) | 4 | 2 | `1:number` | 14164 | Yes |
| [`SHIP_SPAWN_CINEMATIC_FINISHED`](SHIP_SPAWN_CINEMATIC_FINISHED.md) | 10 | 1 | `0:` | no arguments | — |
| [`SHIP_SPAWNED`](SHIP_SPAWNED.md) | 10 | 2 | `0:` | no arguments | Yes |
| [`SHIP_UPDATED`](SHIP_UPDATED.md) | 5 | 2 | `1:number` | 14168 | Yes |
| [`SHOW_STATION`](SHOW_STATION.md) | 2 | 1 | `0:` | no arguments | Yes |
| [`STATION_UPDATE_DESIREDITEMS`](STATION_UPDATE_DESIREDITEMS.md) | 2 | 1 | `0:` | no arguments | — |
| [`STORM_STARTED`](STORM_STARTED.md) | 1 | 1 | `0:` | no arguments | Yes |
| [`STORM_STOPPED`](STORM_STOPPED.md) | 7 | 2 | `0:` | no arguments | Yes |
| [`TARGET_CHANGED`](TARGET_CHANGED.md) | 7 | 2 | `0:` | no arguments | Yes |
| [`TARGET_SCANNED`](TARGET_SCANNED.md) | 19 | 2 | `3:string,number,number` | "Ship too far to scan\; 10; 99 | Yes |
| [`TRANSACTION_COMPLETED`](TRANSACTION_COMPLETED.md) | 7 | 2 | `1:number` | 0 | — |
| [`UPDATE_CHARINFO`](UPDATE_CHARINFO.md) | 2 | 2 | `1:number` | 30460008 | — |
| [`UPDATE_NEWS_HEADLINES`](UPDATE_NEWS_HEADLINES.md) | 8 | 1 | `0:` | no arguments | — |
| [`WARP_OUT_CINEMATIC_FINISHED`](WARP_OUT_CINEMATIC_FINISHED.md) | 8 | 1 | `0:` | no arguments | — |

## Method and privacy

Only approved no-argument getters were invoked during selected callbacks. Context strings are recorded **by type only**, and chat-related callback payloads remain redacted. Table previews are bounded, and userdata is not traversed. Event counts do not identify which sample occurred most often; the report does not contain individual callback timestamps.

See the [event index](index.md), [context correlation guide](context-correlation.md), and [documentation conventions](../reference-conventions.md).
