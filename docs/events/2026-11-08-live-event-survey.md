# Live event observations — November 8, 2026

**Status:** Live client evidence; provisional event signatures.

The APIProbe broad watcher recorded **42 distinct event names** from **214 historical candidates**, capturing **44 distinct argument-type signatures** in one snapshot (`20261108T223840.636743Z-24300-000001.txt`).
The occurrence totals below are per event, and **not per signature**. Across the 42 observed names, the watcher counted 287 callback deliveries. Its signatures are sampled: it keeps up to two distinct type signatures per event and does not attempt to preserve every changing value.

These are observed callback arguments **after the event name** passed into `OnEvent(event, ...)`. `none` means zero arguments, whereas `(nil)` means one argument explicitly equal to `nil`. Values from chat events were deliberately not collected by the plugin.

**Example convention:** `(5570)` means the callback received one numeric argument with value `5570`; `("dock")` means one string argument. `()` means **no additional arguments**, while `(nil)` means **one explicit nil argument**. Parentheses are for illustration, not Lua tables. Each example comes from a recorded callback and is *not* a constant or a guarantee for future events. Where only a table preview was recorded, the full table structure is unknown. Chat-related argument values are intentionally absent.

| Event name | Observed callback argument types | Occurrences | Example arguments from the game |
| --- | --- | ---: | --- |
| [`ACTIVATE_CHAT_CHANNEL`](ACTIVATE_CHAT_CHANNEL.md) | none | 1 | `()` |
| [`CHAT_CANCELLED`](CHAT_CANCELLED.md) | none | 1 | `()` |
| [`CHAT_DONE`](CHAT_DONE.md) | none | 1 | `()` |
| [`CHAT_MSG_BARENTER`](CHAT_MSG_BARENTER.md) | (`table`) | 1 | one table argument (contents redacted) |
| [`CHAT_MSG_BARLIST`](CHAT_MSG_BARLIST.md) | (`table`) | 1 | one table argument (contents redacted) |
| [`CHAT_MSG_SECTORD_SECTOR`](CHAT_MSG_SECTORD_SECTOR.md) | (`table`) | 1 | one table argument (contents redacted) |
| [`CHAT_MSG_SERVER_SECTOR`](CHAT_MSG_SERVER_SECTOR.md) | (`table`) | 4 | one table argument (contents redacted) |
| [`CINEMATIC_START`](CINEMATIC_START.md) | (`boolean`) **or** (`number`) | 9 | `(false)` or `(4)` |
| [`COMMAND`](COMMAND.md) | (`number`) **or** (`number`, `table`) | 4 | `(number)` or `(number, table)`; values redacted |
| [`DESIRED_SPEED_CHANGED`](DESIRED_SPEED_CHANGED.md) | none | 120 | `()` |
| [`ENTER_ZONE_dock`](ENTER_ZONE_dock.md) | (`string`) | 1 | `("dock")` |
| [`ENTER_ZONE_NFZ`](ENTER_ZONE_NFZ.md) | (`string`) | 2 | `("NFZ")` |
| [`ENTER_ZONE_wormhole`](ENTER_ZONE_wormhole.md) | (`string`) | 2 | `("wormhole")` |
| [`ENTERED_STATION`](ENTERED_STATION.md) | none | 1 | `()` |
| [`ENTERING_STATION`](ENTERING_STATION.md) | none | 1 | `()` |
| [`HUD_HIDE`](HUD_HIDE.md) | none | 10 | `()` |
| [`HUD_SHOW`](HUD_SHOW.md) | (`string`) | 5 | `("ship")` |
| [`LEAVE_ZONE_dock`](LEAVE_ZONE_dock.md) | (`string`) | 1 | `("dock")` |
| [`LEAVE_ZONE_NFZ`](LEAVE_ZONE_NFZ.md) | (`string`) | 2 | `("NFZ")` |
| [`LEAVE_ZONE_wormhole`](LEAVE_ZONE_wormhole.md) | (`string`) | 1 | `("wormhole")` |
| [`LEAVING_STATION`](LEAVING_STATION.md) | none | 1 | `()` |
| [`MISSIONLIST_UPDATED`](MISSIONLIST_UPDATED.md) | (`nil`) | 12 | `(nil)` — one actual nil argument |
| [`MSG_NOTIFICATION`](MSG_NOTIFICATION.md) | (`string`, `number`, `boolean`, `boolean`) | 3 | `("Press the Activate key to enter wormhole to Sedina.", 5000, false, false)` |
| [`NAVMENU_TOGGLE`](NAVMENU_TOGGLE.md) | none | 1 | `()` |
| [`NAVROUTE_CHANGED`](NAVROUTE_CHANGED.md) | (`table`) | 2 | one table argument; shallow preview `{"1": number}` |
| [`PLAYER_ENTERED_SECTOR`](PLAYER_ENTERED_SECTOR.md) | (`number`) | 17 | `(30444115)` |
| [`PLAYER_LEFT_SECTOR`](PLAYER_LEFT_SECTOR.md) | (`number`) | 30 | `(30445388)` |
| [`PLAYER_STATS_UPDATED`](PLAYER_STATS_UPDATED.md) | (`number`) | 4 | `(345929)` |
| [`PLAYER_UPDATE`](PLAYER_UPDATE.md) | (`number`) | 9 | `(345929)` |
| [`PLAYER_UPDATE_STATS`](PLAYER_UPDATE_STATS.md) | (`number`) | 4 | `(345929)` |
| [`PLAYERLIST_CLOSE`](PLAYERLIST_CLOSE.md) | none | 1 | `()` |
| [`SECTOR_CHANGED`](SECTOR_CHANGED.md) | (`number`) | 4 | `(5570)` |
| [`SECTOR_LOADED`](SECTOR_LOADED.md) | none | 4 | `()` |
| [`SHIP_SPAWN_CINEMATIC_FINISHED`](SHIP_SPAWN_CINEMATIC_FINISHED.md) | none | 5 | `()` |
| [`SHIP_SPAWNED`](SHIP_SPAWNED.md) | none | 5 | `()` |
| [`SHOW_STATION`](SHOW_STATION.md) | none | 1 | `()` |
| [`STORM_STARTED`](STORM_STARTED.md) | none | 1 | `()` |
| [`STORM_STOPPED`](STORM_STOPPED.md) | none | 3 | `()` |
| [`TARGET_CHANGED`](TARGET_CHANGED.md) | none | 2 | `()` |
| [`TRANSACTION_COMPLETED`](TRANSACTION_COMPLETED.md) | (`number`) | 1 | `(0)` |
| [`UPDATE_NEWS_HEADLINES`](UPDATE_NEWS_HEADLINES.md) | none | 4 | `()` |
| [`WARP_OUT_CINEMATIC_FINISHED`](WARP_OUT_CINEMATIC_FINISHED.md) | none | 4 | `()` |

## Findings and interpretation

- **Sector lifecycle:** `SECTOR_CHANGED` carried one numeric sector ID (sample `5570`) in four deliveries. `SECTOR_LOADED` had zero arguments in four deliveries; combined with the previous single observation this is five observed zero-argument deliveries. `ENTERING_STATION`, `ENTERED_STATION`, `LEAVING_STATION`, and `SHOW_STATION` each had zero arguments in this session.
- **Targets:** `TARGET_CHANGED` had zero arguments twice. To discover the new target after receiving it, a plugin can use a separate getter such as `GetTargetInfo()` (observed independently).
- **Cinematics:** `CINEMATIC_START` had **two different signatures**, `(boolean)` (sample `false`) and `(number)` (sample `4`). Both signatures show the *same event-wide count of nine*; the capture does not provide the frequency of each signature.
- **Commands:** `COMMAND` had both `(number)` and `(number, table)` forms in four overall occurrences. The arguments’ values were omitted to avoid collecting chat/command content. The historical reference suggests the numeric value is a command ID and the table contains arguments, but we have not matched numeric IDs to specific commands here.
- **Mission list:** `MISSIONLIST_UPDATED` supplied **one explicit nil** in 12 deliveries. Do not rewrite this observation as ‘no arguments.’
- **Gameplay notification:** `MSG_NOTIFICATION` supplied `(string, number, boolean, boolean)` in three deliveries. A sampled notification was `"Press the Activate key to enter wormhole to Sedina."`, followed by `5000`, `false`, `false`. The meanings of the latter three values remain provisional.
- **Zones:** `ENTER_ZONE_NFZ`, `ENTER_ZONE_dock`, and `ENTER_ZONE_wormhole` each returned a matching string (`"NFZ"`, `"dock"`, `"wormhole"`), and similarly for the observed `LEAVE_ZONE_*` events. This is richer than the historical entries, which mostly omit argument details.
- **Storms:** `STORM_STARTED` occurred once and `STORM_STOPPED` three times, each with no arguments. This corroborates the historical zero-argument descriptions.
- **Players:** `PLAYER_ENTERED_SECTOR` (17), `PLAYER_LEFT_SECTOR` (30), `PLAYER_UPDATE` (9), `PLAYER_STATS_UPDATED` (4), and `PLAYER_UPDATE_STATS` (4) each supplied a number. The values are consistent with character IDs but not independently resolved against player identities.
- **UI events:** `HUD_SHOW` supplied a string (sample `"ship"`) while `HUD_HIDE` had no arguments. `NAVROUTE_CHANGED` supplied a table with a shallow type preview; this does not establish its full contents.
- **Chat privacy:** `CHAT_*` and `ACTIVATE_CHAT_*` event argument types were captured, but player chat message content was not. The report generator’s `chat event payloads redacted: 0` counter refers only to standalone chat-category captures; it does **not** mean the source-side event redaction failed.

## Remaining limitations

- Observing 42 names does not establish that the other 172 historical event names are absent; they may require special gameplay circumstances or may no longer be used.
- No ordering or timestamps were saved for individual callbacks in the aggregated snapshot. We cannot prove event ordering from this artifact.
- The watcher stores only the first two unique type signatures per event and one argument example per signature. Its count is the *total event occurrences*, not a sample count per signature.
- Sample table previews show only a few key types, not full table data. Chat payload values are intentionally absent.
- Every observation is client-specific and provisional until replicated or compared with known game states.

**Source:** APIProbe `api-event-watch-v1`, snapshot `20261108T223840.636743Z-24300-000001.txt` (UTC), temporarily published via `docs/research/capture-summary.md` and then consolidated into this permanent reference. Historical context: the Racecar2 `Eventtype` page last edited March 2024.
