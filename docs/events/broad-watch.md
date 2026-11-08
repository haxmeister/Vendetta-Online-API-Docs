# Broad event observation

**Status:** Implemented; awaiting an in-game integration test.

The historical Vendetta Lua `Eventtype` reference lists 215 entries, with `PLAYERLIST_TOGGLE` repeated. APIProbe contains **214 distinct event names** in [`events.lua`](../../plugin/APIProbe/events.lua). This is a *candidate list*, not proof that all names can be registered or that they still fire.

## Usage

~~~text
/apidocs connect
/apidocs watch all
~~~

Play normally: dock/launch, travel, change targets, open the HUD and nav menu. Then:

~~~text
/apidocs flush
/apidocs stop
~~~

`/apidocs flush` writes buffered summaries without unregistering. `/apidocs stop` also flushes before disconnecting; `/apidocs unwatch all` flushes and unregisters only the broad watches. `/apidocs watch NAME` still captures individual events in detail (up to 20 samples each).

**Do not reload the interface before flushing**: unflushed observations are in Lua memory and can be lost on reload.

## Capture volume

Watching all 214 names does **not** send every callback to the collector.

- Each event keeps a count of occurrences.
- Only its first **two distinct argument-type signatures** are sampled in a session; identical types are not recorded repeatedly.
- Up to 16 argument positions are inspected, with a bounded example of each non-chat value.
- A global cap of 512 unique signatures prevents unbounded memory use.
- Samples are buffered and sent by `flush` as `snapshot/event-watch` records, chunked to a few dozen kilobytes per file rather than creating thousands of individual event files.
- Chat-related event values are never included, including `CHAT_*`, `ACTIVATE_CHAT_*`, `COMMAND`, and `EMOTE_ENTERED`. Their argument types remain observable.

The event list is based on documentation last edited in March 2024. It includes events which might have been removed or which require rare circumstances; not observing an event is **not** proof that it is absent.

## Sample snapshot format

~~~text
format=api-event-watch-v1
source=historical-event-candidates
candidate_count=214
observed_events=2
part=1
signature=1:number
occurrences=3
event=SECTOR_CHANGED
arguments=1
arg1 type=number value=5597

---
signature=0:
occurrences=4
event=TARGET_CHANGED
arguments=0
~~~

Values shown above are illustrative. Individual live captures should be labeled observed before promotion into the reference.

## Git handoff and retention

The local collector saves raw snapshots in `captures/` (Git-ignored). `tools/share-observations.pl --push` publishes **only captures newer than the current reviewed-through marker**, in one temporary Markdown report. After review, maintainers consolidate findings in permanent reference pages, advance `data/reviewed-through.txt` and delete the temporary report from the current branch. Git history still contains prior versions and must not be treated as secure deletion.
