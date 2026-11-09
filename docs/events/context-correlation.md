# Correlating VO event arguments with game state

**Status:** Context correlation has now been verified by a live `api-event-watch-v3` capture (2026-11-09 UTC), with 31 contextual examples across 17 event names. [See the fourth live survey.](2026-11-09-context-live-event-survey.md)

The [broad watcher](broad-watch.md) already records event names, callback argument types and examples. The correlation mode adds **read-only game state values gathered while the sampled event callback is running**, which helps us investigate what its numeric arguments might mean.

## Use it without registering events one by one

Start the local Perl collector, then issue these commands in VO:

~~~text
/apidocs connect
/apidocs context on
/apidocs watch all
~~~

Play normally. Changing sectors, docking and undocking, targeting objects, flying into storms, and changing ships will produce the most useful correlations. When finished:

~~~text
/apidocs stop
~~~

If stop reports queued TCP bytes, keep the collector and game running. Use
`/apidocs status` until it reports `TCP pending 0 bytes`, then issue
`/apidocs stop` again to disconnect. Event callbacks are already unregistered,
so waiting does not collect more events.

Publish the new report for review:

~~~sh
perl tools/share-observations.pl --push
~~~

The context setting is **off by default**. Use `/apidocs context off` to disable it without disabling event observation. `/apidocs status` reports its current setting.

## What it records

Context uses only the twelve explicitly approved, read-only, no-argument getters from [`inspections.lua`](../../plugin/APIProbe/inspections.lua). No arbitrary Lua function calls are generated.

For example:

| Event | Context getters sampled |
| --- | --- |
| `SECTOR_CHANGED` | `GetCurrentSectorid`, `GetCurrentSystemid`, `PlayerInStation` |
| `SECTOR_LOADED` | `GetCurrentSectorid`, `GetCurrentSystemid` |
| `TARGET_CHANGED`, `TARGET_SCANNED` | `GetTargetInfo`, `GetTargetDistance` |
| `ENTERED_STATION`, `LEAVING_STATION` | `PlayerInStation`, `GetCurrentStationID` (and sector ID for entering) |
| `SHIP_CHANGED`, `SHIP_SPAWNED` | Selected active-ship status and health getters |
| `STORM_STARTED`, `STORM_STOPPED` | `IsStormPresent`, `GetCurrentSectorid` |
| `PLAYER_DIED`, `PLAYER_GOT_HIT` | Selected active-ship, health, and current-sector getters |
| `MISSIONLIST_UPDATED`, `CINEMATIC_START` | Selected station and sector getters |
| `NAVROUTE_CHANGED`, `NAVROUTE_ADD` | Current sector and system IDs |

Other events continue to be observed normally without extra getter calls.

A future `api-event-watch-v3` sample could look like this (illustrative, **not an observed correlation**):

~~~text
signature=1:number
shape=number
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=4764
context=callback-time-approved-getters-v1
context.GetCurrentSectorid=1[number:4764]
context.GetCurrentSystemid=1[number:19]
context.PlayerInStation=1[boolean:false]
~~~

Each `context.GetterName` entry contains the **exact number of returned values**, their types, and their numeric or boolean values. Strings are **type-only**; no player names, target names, chat messages, or string contents are included in context. If a getter fails in a particular state, the entry reads `error` without exposing the error message.

## Limits and interpretation

- Context is sampled **only when a relevant event example is eligible for capture**, not on every callback. A maximum of twelve context probes per event prevents repeated expensive getter calls.
- Broad-watch sampling still has six shape groups per event, two recorded examples per shape, and a global ceiling of 512 examples.
- Getter values can make otherwise identical event arguments useful as different samples, still subject to those limits.
- Chat and command events never trigger context getter inspection.
- `/apidocs stop` flushes and clears the session's sample quotas. A later watch-all run can record fresh examples rather than inheriting exhausted limits.
- The getter runs during the event callback. **Its value is not necessarily the state before or after the transition**, and equality between an event number and a getter value is a **correlation, not proof** of meaning.
- These extra getter calls can increase callback work. If they affect gameplay responsiveness, turn context off and use normal broad-watch mode.

When reviewing reports, look for **repeated matches and mismatches** across deliberately different game states before naming a callback field. For example, an event numeric argument matching `GetCurrentSectorid()` across several sector changes is stronger evidence than one matching value.

## First verified live results

The November 9 UTC report established repeated matches for `SECTOR_CHANGED` and `GetCurrentSectorid()`, and documented station and storm state at callback time. It also supplied useful **counterexamples**: a `NAVROUTE_CHANGED` table value differed from the current sector ID, and `TARGET_SCANNED` numeric arguments differed from the contemporaneous target distance. Full values and caveats are preserved in the [live context survey](2026-11-09-context-live-event-survey.md).
