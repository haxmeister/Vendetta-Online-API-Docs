# November 9, 2026 automated capture — review in progress

**Source:** `docs/research/capture-summary.md`, three snapshots: `20261109T013130.298625Z-25441-000001.txt`, `20261109T013430.297695Z-25441-000002.txt`, and `20261109T013730.312126Z-25441-000003.txt`.

**Review state:** Partial. This batch contains three broad-watch snapshots, no standalone function inspections, and 53 distinct observed event names. Several event pages have been updated, but the complete batch has **not** yet been consolidated. Keep the report and leave `data/reviewed-through.txt` unchanged until all event pages and the index have been validated.

## Key observations

- `CINEMATIC_START` showed zero arguments, one boolean `false`, or one numeric value (`4` or `6`), depending on callback.
- `MISSIONLIST_UPDATED` had one `nil` argument in flight and one number (`3`) while docked. This is a correlation, not an established argument definition.
- `NAVROUTE_CHANGED` supplied tables such as `{[1]=4735}`, `{[1]=4764}`, and `{}`; callback-time sector context varied.
- `TARGET_CHANGED` supplied zero arguments, while `GetTargetInfo` and `GetTargetDistance` provided varying return counts. `TARGET_SCANNED` supplied a message string and two numbers; their meanings remain uncertain.
- `PLAYER_DIED` supplied four numbers, with its fourth number `4780` matching the callback-time sector ID. The match supports a tentative hypothesis only.
- `SHIP_CHANGED` and `SHIP_SPAWNED` correlated with changing `HasActiveShip` and `GetActiveShipHealth` results; the latter returned ten values in the shown active-ship states.
- `CONQUERED_SECTORS_UPDATED` included table examples `{[8]=true}`, `{[20]=true}`, and `{[27]=true}`. The sample does not establish the complete table schema.
- Chat-related event values are redacted and must not be reconstructed from names or guessed.

**Count caveat:** The broad watcher retains cumulative event occurrence counters across flushes. Snapshot counts must not be added as independent callback totals or mistaken for per-signature counts.

## Remaining work

Complete all 53 individual event-page updates, reconcile any previously recorded signatures, update the event index and getter reference where appropriate, verify the final captured timestamp, then advance the review marker and remove the temporary report. The three snapshot filenames are evidence identifiers; raw captures remain on the user's local machine.
