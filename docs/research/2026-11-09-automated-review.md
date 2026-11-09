# November 9, 2026 — completed nine-snapshot context review

**Status: Fully consolidated through 20261109T015830.306827Z UTC.**

The public handoff contained nine incremental `api-event-watch-v3` snapshots, from `20261109T013130.298625Z-25441-000001.txt` through `20261109T015830.306827Z-25441-000009.txt`. They were successive flushes of **one** continuing watch session, with **70 distinct event names**, **106 saved examples**, and **43 callback-time getter context examples across 19 event names**. There were no independent function-inspection records in this handoff.

All nine snapshots are indexed in the permanent [fifth live event survey](../events/2026-11-09-fifth-live-event-survey.md). Forty individual event pages were updated with the most informative new signatures, values, contextual getter observations and cross-event comparisons. The other observed events, primarily previously documented signatures and privacy-redacted chat callbacks, are included in the survey table. No chat message contents or keys were reproduced.

## Findings

- `SECTOR_CHANGED` argument 1 matched `GetCurrentSectorid()` in two more samples, 4735 and 4764. Combining these with earlier cross-system observations strengthens the sector-ID interpretation without making it absolute.
- `PLAYER_DIED` argument 4 matched the current sector at 4780 and 5076. Its first three fields remain unverified; `HasActiveShip()` could differ at callback time.
- `TARGET_CHANGED` still delivered no arguments, despite getter state ranging from no target to a seven-return-value target. Target-info third return and target-distance first return agreed in the targeted sample.
- `TARGET_SCANNED` delivered message plus the numeric arguments 11 and 842 with different contextual distances; neither numeric field was the sampled distance.
- `TARGET_HEALTH_UPDATE` delivered `(-1,0)` and `(90,0)`. The latter coincided with target-info return 2 `0.90614457831325`, suggesting—but not proving—a possible health-percentage relationship.
- `NAVROUTE_CHANGED` tables could contain sector-like numbers **different** from the current sector; `MISSIONLIST_UPDATED` delivered explicit nil in both docked and undocked contexts.
- `SHIP_CHANGED` produced a numeric argument when no active ship existed. In this state the name getter yielded one nil and the health getter yielded **zero values**, contrasting with ten health return positions when a ship was present.
- `ENTERING_STATION`, `ENTERED_STATION`, and `SHOW_STATION` found the player already inside a station at callback time. `LEAVING_STATION` found the opposite. All had zero arguments in these examples.
- First recorded live callbacks for `CHAT_MSG_CHANNEL`, `MISSION_QUESTION_OPEN`, `PLAYER_HIT`, `PLAYER_UPDATE_SKILLS`, `SYSMENU_TOGGLE`, and `SYSTEM_BEST_PRICE` raised cumulative observed coverage from **69 to 75 of 214** historical names.

## Interpretation, coverage and retention

The collector's event counters are cumulative across flushes. They were not added together or treated as per-example frequencies. Context getters execute while the callback runs, so a match indicates correlation, not definitive callback semantics or before/after ordering.

The [observed getter reference](../functions/observed-getters.md) was revised for callback-time return behavior. The count of **168 formally inspected getter calls** was not increased by context samples.

After this consolidation, `data/reviewed-through.txt` advances to `20261109T015830.306827Z` and the temporary capture report is removed from the tip of `main`. Earlier commits may still contain the report; Git deletion does not erase history. Raw captures remain local in Git-ignored `captures/`.
