# Second live event survey — November 8, 2026

**Status:** Recorded in a VO client, not a definitive API contract.

The new `api-event-watch-v2` snapshot (`20261108T233831.046307Z-24651-000061.txt`) contains **52 event names**, **65 bounded example payloads**, and **569 total callback deliveries**. There were **12 previously unobserved event names**, bringing combined first-and-second-session coverage to **54 of the 214 candidate event names**. Two names observed in the first session did not fire in the second.

The occurrence counts are per **event**, not per example or signature. One event can supply several different examples from the same callback argument type.

## Twelve newly observed event names

- [`CHAT_ENTERED`](CHAT_ENTERED.md)
- [`CHAT_MSG_CHANNEL_ACTIVE`](CHAT_MSG_CHANNEL_ACTIVE.md)
- [`CHAT_MSG_CHANNEL_EMOTE_ACTIVE`](CHAT_MSG_CHANNEL_EMOTE_ACTIVE.md)
- [`CONQUERED_SECTORS_UPDATED`](CONQUERED_SECTORS_UPDATED.md)
- [`INVENTORY_UPDATE`](INVENTORY_UPDATE.md)
- [`PLAYER_GOT_HIT`](PLAYER_GOT_HIT.md)
- [`PLAYER_GUILD_TAG_UPDATED`](PLAYER_GUILD_TAG_UPDATED.md)
- [`SHIP_UPDATED`](SHIP_UPDATED.md)
- [`STATION_UPDATE_DESIREDITEMS`](STATION_UPDATE_DESIREDITEMS.md)
- [`TARGET_HEALTH_UPDATE`](TARGET_HEALTH_UPDATE.md)
- [`TARGET_SCANNED`](TARGET_SCANNED.md)
- [`UPDATE_CHARINFO`](UPDATE_CHARINFO.md)

## All events captured in the second session

| Event | Total callbacks | Saved examples | Type signature(s) | First example |
| --- | ---: | ---: | --- | --- |
| [`ACTIVATE_CHAT_CHANNEL`](ACTIVATE_CHAT_CHANNEL.md) | 5 | 1 | `0:` | Argument values redacted |
| [`CHAT_DONE`](CHAT_DONE.md) | 11 | 1 | `0:` | Argument values redacted |
| [`CHAT_ENTERED`](CHAT_ENTERED.md) | 5 | 1 | `1:string` | Argument values redacted |
| [`CHAT_MSG_BARENTER`](CHAT_MSG_BARENTER.md) | 1 | 1 | `1:table` | Argument values redacted |
| [`CHAT_MSG_BARLIST`](CHAT_MSG_BARLIST.md) | 1 | 1 | `1:table` | Argument values redacted |
| [`CHAT_MSG_CHANNEL_ACTIVE`](CHAT_MSG_CHANNEL_ACTIVE.md) | 9 | 1 | `1:table` | Argument values redacted |
| [`CHAT_MSG_CHANNEL_EMOTE_ACTIVE`](CHAT_MSG_CHANNEL_EMOTE_ACTIVE.md) | 1 | 1 | `1:table` | Argument values redacted |
| [`CHAT_MSG_SECTORD_SECTOR`](CHAT_MSG_SECTORD_SECTOR.md) | 3 | 1 | `1:table` | Argument values redacted |
| [`CHAT_MSG_SERVER_SECTOR`](CHAT_MSG_SERVER_SECTOR.md) | 8 | 1 | `1:table` | Argument values redacted |
| [`CINEMATIC_START`](CINEMATIC_START.md) | 17 | 3 | `1:boolean; 1:number` | arguments=1; false |
| [`COMMAND`](COMMAND.md) | 29 | 2 | `1:number; 2:number,table` | Argument values redacted |
| [`CONQUERED_SECTORS_UPDATED`](CONQUERED_SECTORS_UPDATED.md) | 2 | 2 | `1:table` | arguments=1; table{[27]=true} |
| [`ENTER_ZONE_dock`](ENTER_ZONE_dock.md) | 1 | 1 | `1:string` | arguments=1; "dock" (bytes=4) |
| [`ENTER_ZONE_NFZ`](ENTER_ZONE_NFZ.md) | 2 | 1 | `1:string` | arguments=1; "NFZ" (bytes=3) |
| [`ENTER_ZONE_wormhole`](ENTER_ZONE_wormhole.md) | 7 | 1 | `1:string` | arguments=1; "wormhole" (bytes=8) |
| [`ENTERED_STATION`](ENTERED_STATION.md) | 1 | 1 | `0:` | arguments=0 |
| [`ENTERING_STATION`](ENTERING_STATION.md) | 1 | 1 | `0:` | arguments=0 |
| [`HUD_HIDE`](HUD_HIDE.md) | 18 | 1 | `0:` | arguments=0 |
| [`HUD_SHOW`](HUD_SHOW.md) | 9 | 1 | `1:string` | arguments=1; "ship" (bytes=4) |
| [`INVENTORY_UPDATE`](INVENTORY_UPDATE.md) | 2 | 1 | `1:number` | arguments=1; 14156 |
| [`LEAVE_ZONE_dock`](LEAVE_ZONE_dock.md) | 1 | 1 | `1:string` | arguments=1; "dock" (bytes=4) |
| [`LEAVE_ZONE_NFZ`](LEAVE_ZONE_NFZ.md) | 2 | 1 | `1:string` | arguments=1; "NFZ" (bytes=3) |
| [`LEAVE_ZONE_wormhole`](LEAVE_ZONE_wormhole.md) | 4 | 1 | `1:string` | arguments=1; "wormhole" (bytes=8) |
| [`LEAVING_STATION`](LEAVING_STATION.md) | 1 | 1 | `0:` | arguments=0 |
| [`MISSIONLIST_UPDATED`](MISSIONLIST_UPDATED.md) | 28 | 1 | `1:nil` | arguments=1; nil |
| [`MSG_NOTIFICATION`](MSG_NOTIFICATION.md) | 8 | 2 | `4:string,number,boolean,boolean` | arguments=4; "Press the Activate key to enter wormhole to Latos." (bytes=50); 5000; false; false |
| [`NAVMENU_TOGGLE`](NAVMENU_TOGGLE.md) | 2 | 1 | `0:` | arguments=0 |
| [`NAVROUTE_CHANGED`](NAVROUTE_CHANGED.md) | 2 | 2 | `1:table` | arguments=1; table{[1]=4763} |
| [`PLAYER_ENTERED_SECTOR`](PLAYER_ENTERED_SECTOR.md) | 120 | 2 | `1:number` | arguments=1; 345929 |
| [`PLAYER_GOT_HIT`](PLAYER_GOT_HIT.md) | 2 | 2 | `6:number,number,number,boolean,number,userdata` | arguments=6; 345929; 883607; 1302; true; 2; <userdata> |
| [`PLAYER_GUILD_TAG_UPDATED`](PLAYER_GUILD_TAG_UPDATED.md) | 2 | 2 | `1:number` | arguments=1; 30452221 |
| [`PLAYER_LEFT_SECTOR`](PLAYER_LEFT_SECTOR.md) | 130 | 2 | `1:number` | arguments=1; 30451711 |
| [`PLAYER_STATS_UPDATED`](PLAYER_STATS_UPDATED.md) | 8 | 1 | `1:number` | arguments=1; 345929 |
| [`PLAYER_UPDATE`](PLAYER_UPDATE.md) | 17 | 1 | `1:number` | arguments=1; 345929 |
| [`PLAYER_UPDATE_STATS`](PLAYER_UPDATE_STATS.md) | 8 | 1 | `1:number` | arguments=1; 345929 |
| [`PLAYERLIST_CLOSE`](PLAYERLIST_CLOSE.md) | 8 | 1 | `0:` | arguments=0 |
| [`SECTOR_CHANGED`](SECTOR_CHANGED.md) | 8 | 2 | `1:number` | arguments=1; 4978 |
| [`SECTOR_LOADED`](SECTOR_LOADED.md) | 8 | 1 | `0:` | arguments=0 |
| [`SHIP_SPAWN_CINEMATIC_FINISHED`](SHIP_SPAWN_CINEMATIC_FINISHED.md) | 9 | 1 | `0:` | arguments=0 |
| [`SHIP_SPAWNED`](SHIP_SPAWNED.md) | 9 | 1 | `0:` | arguments=0 |
| [`SHIP_UPDATED`](SHIP_UPDATED.md) | 2 | 1 | `1:number` | arguments=1; 14156 |
| [`SHOW_STATION`](SHOW_STATION.md) | 1 | 1 | `0:` | arguments=0 |
| [`STATION_UPDATE_DESIREDITEMS`](STATION_UPDATE_DESIREDITEMS.md) | 2 | 1 | `0:` | arguments=0 |
| [`STORM_STARTED`](STORM_STARTED.md) | 1 | 1 | `0:` | arguments=0 |
| [`STORM_STOPPED`](STORM_STOPPED.md) | 7 | 1 | `0:` | arguments=0 |
| [`TARGET_CHANGED`](TARGET_CHANGED.md) | 5 | 1 | `0:` | arguments=0 |
| [`TARGET_HEALTH_UPDATE`](TARGET_HEALTH_UPDATE.md) | 1 | 1 | `2:number,number` | arguments=2; -1; 0 |
| [`TARGET_SCANNED`](TARGET_SCANNED.md) | 21 | 2 | `3:string,number,number` | arguments=3; "Cargo Hold Empty\; 3; 1292 |
| [`TRANSACTION_COMPLETED`](TRANSACTION_COMPLETED.md) | 1 | 1 | `1:number` | arguments=1; 0 |
| [`UPDATE_CHARINFO`](UPDATE_CHARINFO.md) | 2 | 2 | `1:number` | arguments=1; 30452221 |
| [`UPDATE_NEWS_HEADLINES`](UPDATE_NEWS_HEADLINES.md) | 8 | 1 | `0:` | arguments=0 |
| [`WARP_OUT_CINEMATIC_FINISHED`](WARP_OUT_CINEMATIC_FINISHED.md) | 8 | 1 | `0:` | arguments=0 |

## Findings

- `NAVROUTE_CHANGED` produced `table{[1]=4763}` and `table{}`, confirming a changed table shape.
- `CONQUERED_SECTORS_UPDATED` produced `table{[27]=true}` and `table{[8]=true}`. Their index meanings are unverified.
- `PLAYER_GOT_HIT` delivered six arguments, ending in opaque userdata.
- `TARGET_SCANNED` produced two different scan-result strings (both with a trailing newline) followed by `3` and `1292`.
- `CINEMATIC_START` delivered a boolean or a number, with numeric values `4` and `6` saved.
- `MSG_NOTIFICATION` captured two wormhole-destination messages, preserving the same remaining argument values.
- Chat events and `COMMAND` were observed only by argument count/type; message text and related payload values were not recorded.

Each event's [individual page](index.md) includes **all available sampled values and shapes** from this session, including the multiple examples omitted from the compact table above.

## Limitations

This capture does not record individual callback timing, the frequency of each argument shape, or complete table structures. Values may depend on game state. The observer stores at most six distinct shapes and two examples per shape, so additional variations may not have been sampled.
