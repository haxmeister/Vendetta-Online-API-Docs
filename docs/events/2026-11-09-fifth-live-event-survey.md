# Fifth live event survey — context-enabled captures (November 9, 2026 UTC)

**Evidence:** Nine incremental `api-event-watch-v3` snapshots, `20261109T013130.298625Z-25441-000001.txt` through `20261109T015830.306827Z-25441-000009.txt`.

These snapshots are successive flushes from **one continuing watch session**, not nine independent sessions. They contain **70 distinct event names**, **106 saved examples**, and **43 callback-time getter context examples** across **19 event names**. Six first-observed names are `CHAT_MSG_CHANNEL`, `MISSION_QUESTION_OPEN`, `PLAYER_HIT`, `PLAYER_UPDATE_SKILLS`, `SYSMENU_TOGGLE`, `SYSTEM_BEST_PRICE`. Across all five reviewed live batches, **75 of the 214 historical candidates** have now fired.

The watcher retains cumulative `observed_events` and `occurrences` counters between flushes. They **must not be summed** across snapshot files. Saved examples are bounded samples, not per-signature frequencies.

## Main discoveries and counterexamples

- **Sector changes:** `SECTOR_CHANGED` argument 1 matched `GetCurrentSectorid()` for 4735 and 4764, reinforcing the earlier matching samples.
- **Player deaths:** `PLAYER_DIED` argument 4 matched the callback-time current sector in two further cases, 4780 and 5076. The first three numbers remain unresolved.
- **Target changes:** `TARGET_CHANGED` still delivered no callback arguments; the context getters found both an absent target (zero `GetTargetInfo()` returns) and a present target (seven returns; matched target distances at 1492.4592959274).
- **Target scanning:** `TARGET_SCANNED` had a message and numeric values 11 and 842 while target distance varied. Neither number was the observed distance.
- **Target health:** `TARGET_HEALTH_UPDATE` had `(-1,0)` and `(90,0)`. At the 90 example, `GetTargetInfo()` return 2 was 0.90614457831325, suggestive of—but not proving—a percent or scaled-health relationship.
- **Navigation:** `NAVROUTE_CHANGED` tables had `[1]=4735`, `[1]=4764` and empty `{}` forms. In both populated cases the number differed from the **current** sector getter; do not treat it as always the current sector.
- **Ship transition:** One `SHIP_CHANGED` callback found no active ship and `GetActiveShipHealth()` returned **zero values**; another found an active ship and ten health positions. `SHIP_SPAWNED` had zero callback arguments and context with ten health positions.
- **Stations:** `ENTERING_STATION` and `ENTERED_STATION` delivered no arguments, with `PlayerInStation()=true` and numeric station IDs already available during the callback. `LEAVING_STATION` had false and nil.
- **Mission list:** `MISSIONLIST_UPDATED` delivered explicit nil both docked and undocked; its numeric form `3` was sampled docked. Nil does not signify undocked.
- **Damage callbacks:** `PLAYER_HIT` first fired with zero arguments; `PLAYER_GOT_HIT` independently delivered six including userdata.
- **New signatures:** `MISSION_QUESTION_OPEN` delivered four fields (message, `"Info"`, `"db:1009"`, 1219585); `SYSTEM_BEST_PRICE` delivered numbers 14177, 380, 506701. Do not assign meanings without stronger evidence.

## Event-by-event coverage

| Event | Latest cumulative callbacks | Saved examples | Signature(s) | Representative argument value(s) | Context? |
| --- | ---: | ---: | --- | --- | --- |
| [`ACTIVATE_CHAT_CHANNEL`](ACTIVATE_CHAT_CHANNEL.md) | 2 | 1 | `0:` | redacted | — |
| [`CHAT_CANCELLED`](CHAT_CANCELLED.md) | 1 | 1 | `0:` | redacted | — |
| [`CHAT_DONE`](CHAT_DONE.md) | 2 | 1 | `0:` | redacted | — |
| [`CHAT_MSG_BARENTER`](CHAT_MSG_BARENTER.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_BARLIST`](CHAT_MSG_BARLIST.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_CHANNEL`](CHAT_MSG_CHANNEL.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_CHANNEL_ACTIVE`](CHAT_MSG_CHANNEL_ACTIVE.md) | 8 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_CHANNEL_EMOTE_ACTIVE`](CHAT_MSG_CHANNEL_EMOTE_ACTIVE.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_CONFIRMATION`](CHAT_MSG_CONFIRMATION.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_DEATH`](CHAT_MSG_DEATH.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_PRINT`](CHAT_MSG_PRINT.md) | 2 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_SECTOR`](CHAT_MSG_SECTOR.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_SECTORD`](CHAT_MSG_SECTORD.md) | 2 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_SECTORD_MISSION`](CHAT_MSG_SECTORD_MISSION.md) | 1 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_SECTORD_SECTOR`](CHAT_MSG_SECTORD_SECTOR.md) | 3 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_SERVER`](CHAT_MSG_SERVER.md) | 12 | 1 | `1:table` | redacted | — |
| [`CHAT_MSG_SERVER_SECTOR`](CHAT_MSG_SERVER_SECTOR.md) | 2 | 1 | `1:table` | redacted | — |
| [`CINEMATIC_START`](CINEMATIC_START.md) | 31 | 6 | `1:boolean`, `1:number`, `0:` | false | Yes |
| [`COMMAND`](COMMAND.md) | 4 | 1 | `1:number` | redacted | — |
| [`CONQUERED_SECTORS_UPDATED`](CONQUERED_SECTORS_UPDATED.md) | 6 | 4 | `1:table` | table{[20]=true} | — |
| [`ENTERED_STATION`](ENTERED_STATION.md) | 6 | 2 | `0:` | () | Yes |
| [`ENTERING_STATION`](ENTERING_STATION.md) | 6 | 2 | `0:` | () | Yes |
| [`ENTER_ZONE_NFZ`](ENTER_ZONE_NFZ.md) | 3 | 1 | `1:string` | "NFZ" (bytes=3) | — |
| [`ENTER_ZONE_dock`](ENTER_ZONE_dock.md) | 1 | 1 | `1:string` | "dock" (bytes=4) | — |
| [`ENTER_ZONE_wormhole`](ENTER_ZONE_wormhole.md) | 4 | 1 | `1:string` | "wormhole" (bytes=8) | — |
| [`HUD_HIDE`](HUD_HIDE.md) | 7 | 1 | `0:` | () | — |
| [`HUD_SHOW`](HUD_SHOW.md) | 4 | 1 | `1:string` | "ship" (bytes=4) | — |
| [`INVENTORY_ADD`](INVENTORY_ADD.md) | 3 | 2 | `1:number` | 14172 | — |
| [`INVENTORY_REMOVE`](INVENTORY_REMOVE.md) | 3 | 2 | `1:number` | 11122 | — |
| [`INVENTORY_UPDATE`](INVENTORY_UPDATE.md) | 4 | 2 | `1:number` | 11824 | — |
| [`LEAVE_ZONE_NFZ`](LEAVE_ZONE_NFZ.md) | 2 | 1 | `1:string` | "NFZ" (bytes=3) | — |
| [`LEAVE_ZONE_dock`](LEAVE_ZONE_dock.md) | 1 | 1 | `1:string` | "dock" (bytes=4) | — |
| [`LEAVE_ZONE_wormhole`](LEAVE_ZONE_wormhole.md) | 2 | 1 | `1:string` | "wormhole" (bytes=8) | — |
| [`LEAVING_STATION`](LEAVING_STATION.md) | 2 | 1 | `0:` | () | Yes |
| [`MISSIONLIST_UPDATED`](MISSIONLIST_UPDATED.md) | 16 | 3 | `1:nil`, `1:number` | nil | Yes |
| [`MISSION_QUESTION_OPEN`](MISSION_QUESTION_OPEN.md) | 1 | 1 | `4:string,string,string,number` | "This mission relays some brief information about where to go once you comple... | — |
| [`MSG_LOGOFF_TIMER`](MSG_LOGOFF_TIMER.md) | 11 | 2 | `1:string` | "10 seconds to self-destruct." (bytes=28) | — |
| [`MSG_NOTIFICATION`](MSG_NOTIFICATION.md) | 98 | 2 | `4:string,number,boolean,boolean` | "Press the Activate key to dock." (bytes=31), 5000, false, false | — |
| [`NAVMENU_TOGGLE`](NAVMENU_TOGGLE.md) | 1 | 1 | `0:` | () | — |
| [`NAVROUTE_ADD`](NAVROUTE_ADD.md) | 1 | 1 | `1:number` | 4764 | Yes |
| [`NAVROUTE_CHANGED`](NAVROUTE_CHANGED.md) | 5 | 4 | `1:table` | table{[1]=4735} | Yes |
| [`PLAYER_DEATH_CINEMATIC_FINISHED`](PLAYER_DEATH_CINEMATIC_FINISHED.md) | 1 | 1 | `0:` | () | — |
| [`PLAYER_DIED`](PLAYER_DIED.md) | 2 | 2 | `4:number,number,number,number` | 345929, 345929, 0, 4780 | Yes |
| [`PLAYER_ENTERED_SECTOR`](PLAYER_ENTERED_SECTOR.md) | 22 | 2 | `1:number` | 30465805 | — |
| [`PLAYER_GOT_HIT`](PLAYER_GOT_HIT.md) | 28 | 2 | `6:number,number,number,boolean,number,userdata` | 345929, 1000090299, 571, true, 2, <userdata> | Yes |
| [`PLAYER_GUILD_TAG_UPDATED`](PLAYER_GUILD_TAG_UPDATED.md) | 1 | 1 | `1:number` | 30466963 | — |
| [`PLAYER_HIT`](PLAYER_HIT.md) | 7 | 1 | `0:` | () | — |
| [`PLAYER_LEFT_SECTOR`](PLAYER_LEFT_SECTOR.md) | 29 | 2 | `1:number` | 30465545 | — |
| [`PLAYER_STATS_UPDATED`](PLAYER_STATS_UPDATED.md) | 2 | 1 | `1:number` | 345929 | — |
| [`PLAYER_UPDATE`](PLAYER_UPDATE.md) | 33 | 2 | `1:number` | 345929 | — |
| [`PLAYER_UPDATE_SKILLS`](PLAYER_UPDATE_SKILLS.md) | 1 | 1 | `1:number` | 345929 | — |
| [`PLAYER_UPDATE_STATS`](PLAYER_UPDATE_STATS.md) | 2 | 1 | `1:number` | 345929 | — |
| [`SECTOR_CHANGED`](SECTOR_CHANGED.md) | 2 | 2 | `1:number` | 4735 | Yes |
| [`SECTOR_LOADED`](SECTOR_LOADED.md) | 2 | 2 | `0:` | () | Yes |
| [`SHIP_CHANGED`](SHIP_CHANGED.md) | 4 | 2 | `1:number` | 11824 | Yes |
| [`SHIP_SPAWNED`](SHIP_SPAWNED.md) | 5 | 2 | `0:` | () | Yes |
| [`SHIP_SPAWN_CINEMATIC_FINISHED`](SHIP_SPAWN_CINEMATIC_FINISHED.md) | 4 | 1 | `0:` | () | — |
| [`SHIP_UPDATED`](SHIP_UPDATED.md) | 2 | 2 | `1:number` | 11824 | Yes |
| [`SHOW_STATION`](SHOW_STATION.md) | 6 | 2 | `0:` | () | Yes |
| [`STATION_UPDATE_DESIREDITEMS`](STATION_UPDATE_DESIREDITEMS.md) | 1 | 1 | `0:` | () | — |
| [`STORM_STOPPED`](STORM_STOPPED.md) | 2 | 2 | `0:` | () | Yes |
| [`SYSMENU_TOGGLE`](SYSMENU_TOGGLE.md) | 1 | 1 | `0:` | () | — |
| [`SYSTEM_BEST_PRICE`](SYSTEM_BEST_PRICE.md) | 2 | 1 | `3:number,number,number` | 14177, 380, 506701 | — |
| [`TARGET_CHANGED`](TARGET_CHANGED.md) | 2 | 2 | `0:` | () | Yes |
| [`TARGET_HEALTH_UPDATE`](TARGET_HEALTH_UPDATE.md) | 4 | 2 | `2:number,number` | -1, 0 | Yes |
| [`TARGET_SCANNED`](TARGET_SCANNED.md) | 10 | 2 | `3:string,number,number` | "Ship too far to scan\, 11, 842 | Yes |
| [`TRANSACTION_COMPLETED`](TRANSACTION_COMPLETED.md) | 3 | 2 | `1:number` | 5 | — |
| [`UPDATE_CHARINFO`](UPDATE_CHARINFO.md) | 1 | 1 | `1:number` | 30466963 | — |
| [`UPDATE_NEWS_HEADLINES`](UPDATE_NEWS_HEADLINES.md) | 2 | 1 | `0:` | () | — |
| [`WARP_OUT_CINEMATIC_FINISHED`](WARP_OUT_CINEMATIC_FINISHED.md) | 2 | 1 | `0:` | () | — |

## Collection limits

Context uses only selected approved, no-argument, read-only getters while each event callback is executing. Those values may reflect intermediate game state. Chat-related event values and contextual string contents were omitted, userdata was not traversed, and table previews were bounded. Every original event retains its own page linked above; correlations do not establish universal signatures.
