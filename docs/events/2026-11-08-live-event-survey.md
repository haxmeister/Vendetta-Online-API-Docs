# Live event observations — November 8, 2026

**Status:** Live client evidence; provisional event signatures.

The APIProbe broad watcher recorded **42 distinct event names** from **214 historical candidates**, capturing **44 distinct argument-type signatures** in one snapshot (`20261108T223840.636743Z-24300-000001.txt`).
The occurrence totals below are per event, and **not per signature**. Across the 42 observed names, the watcher counted 287 callback deliveries. Its signatures are sampled: it keeps up to two distinct type signatures per event and does not attempt to preserve every changing value.

These are observed callback arguments **after the event name** passed into `OnEvent(event, ...)`. `none` means zero arguments, whereas `(nil)` means one argument explicitly equal to `nil`. Values from chat events were deliberately not collected by the plugin.

| Event name | Observed argument type(s) | Event occurrences | Sample argument values |
| --- | --- | ---: | --- |
| `ACTIVATE_CHAT_CHANNEL` | none | 1 | Chat values omitted by the watcher |
| `CHAT_CANCELLED` | none | 1 | Chat values omitted by the watcher |
| `CHAT_DONE` | none | 1 | Chat values omitted by the watcher |
| `CHAT_MSG_BARENTER` | (`table`) | 1 | Chat values omitted by the watcher |
| `CHAT_MSG_BARLIST` | (`table`) | 1 | Chat values omitted by the watcher |
| `CHAT_MSG_SECTORD_SECTOR` | (`table`) | 1 | Chat values omitted by the watcher |
| `CHAT_MSG_SERVER_SECTOR` | (`table`) | 4 | Chat values omitted by the watcher |
| `CINEMATIC_START` | (`boolean`) **or** (`number`) | 9 | false / 4 |
| `COMMAND` | (`number`) **or** (`number`, `table`) | 4 | Chat values omitted by the watcher |
| `DESIRED_SPEED_CHANGED` | none | 120 | — |
| `ENTER_ZONE_dock` | (`string`) | 1 | "dock" (bytes=4) |
| `ENTER_ZONE_NFZ` | (`string`) | 2 | "NFZ" (bytes=3) |
| `ENTER_ZONE_wormhole` | (`string`) | 2 | "wormhole" (bytes=8) |
| `ENTERED_STATION` | none | 1 | — |
| `ENTERING_STATION` | none | 1 | — |
| `HUD_HIDE` | none | 10 | — |
| `HUD_SHOW` | (`string`) | 5 | "ship" (bytes=4) |
| `LEAVE_ZONE_dock` | (`string`) | 1 | "dock" (bytes=4) |
| `LEAVE_ZONE_NFZ` | (`string`) | 2 | "NFZ" (bytes=3) |
| `LEAVE_ZONE_wormhole` | (`string`) | 1 | "wormhole" (bytes=8) |
| `LEAVING_STATION` | none | 1 | — |
| `MISSIONLIST_UPDATED` | (`nil`) | 12 | — |
| `MSG_NOTIFICATION` | (`string`, `number`, `boolean`, `boolean`) | 3 | "Press the Activate key to enter wormhole to Sedina." (bytes=51); 5000; false; false |
| `NAVMENU_TOGGLE` | none | 1 | — |
| `NAVROUTE_CHANGED` | (`table`) | 2 | table{"1":number} |
| `PLAYER_ENTERED_SECTOR` | (`number`) | 17 | 30444115 |
| `PLAYER_LEFT_SECTOR` | (`number`) | 30 | 30445388 |
| `PLAYER_STATS_UPDATED` | (`number`) | 4 | 345929 |
| `PLAYER_UPDATE` | (`number`) | 9 | 345929 |
| `PLAYER_UPDATE_STATS` | (`number`) | 4 | 345929 |
| `PLAYERLIST_CLOSE` | none | 1 | — |
| `SECTOR_CHANGED` | (`number`) | 4 | 5570 |
| `SECTOR_LOADED` | none | 4 | — |
| `SHIP_SPAWN_CINEMATIC_FINISHED` | none | 5 | — |
| `SHIP_SPAWNED` | none | 5 | — |
| `SHOW_STATION` | none | 1 | — |
| `STORM_STARTED` | none | 1 | — |
| `STORM_STOPPED` | none | 3 | — |
| `TARGET_CHANGED` | none | 2 | — |
| `TRANSACTION_COMPLETED` | (`number`) | 1 | 0 |
| `UPDATE_NEWS_HEADLINES` | none | 4 | — |
| `WARP_OUT_CINEMATIC_FINISHED` | none | 4 | — |

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
