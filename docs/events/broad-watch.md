# Broad event observation

**Status:** In-game capture verified November 8, 2026. The first broad watch observed 42 distinct events and 44 argument-type signatures, delivered in one snapshot. [See the observed event reference.](2026-11-08-live-event-survey.md)

The historical Vendetta Lua `Eventtype` reference lists 215 entries, with `PLAYERLIST_TOGGLE` repeated. APIProbe contains **214 distinct event names** in [`events.lua`](../../plugin/APIProbe/events.lua). This is a *candidate list*, not proof that all names can be registered or that they still fire.

## Usage

For normal discovery:

~~~text
/apidocs connect
/apidocs watch all
~~~

To investigate **argument meaning**, you can also enable bounded callback-time
context. This reads selected approved game-state getters alongside event
examples:

~~~text
/apidocs connect
/apidocs context on
/apidocs watch all
~~~

See [event context correlation](context-correlation.md) for the exact getter
allowlist, safety limits, interpretation and example records. Context is
**off by default** and can be disabled with `/apidocs context off`.

Play normally: dock/launch, travel, change targets, open the HUD and nav menu. Then:

~~~text
/apidocs flush
/apidocs stop
~~~

`/apidocs flush` writes buffered summaries without unregistering. `/apidocs stop` also flushes before disconnecting; if TCP still has queued bytes, it unregisters callbacks but leaves the connection open to drain. Check `/apidocs status` and run `/apidocs stop` a second time once `TCP pending 0 bytes` is reported. `/apidocs unwatch all` flushes and unregisters only the broad watches. `/apidocs watch NAME` still captures individual events in detail (up to 20 samples each).

**Do not reload the interface before flushing**: unflushed observations are in Lua memory and can be lost on reload.

## Capture volume

Watching all 214 names does **not** send every callback to the collector.

- Each event keeps a count of occurrences.
- The observer identifies **argument types and bounded table shapes**. The first sample of each new shape is captured, plus a second example when its actual values differ.
- Up to **six shapes per event** and **two distinct values per shape** are sampled. Unchanged callbacks are not repeatedly saved; a high-frequency event cannot crowd out every other event.
- Up to 16 argument positions are inspected. Nested tables include primitive values, bounded to 3 levels, 12 keys per table, 64 field visits, and 2,048 bytes per table preview. Cyclic references are handled.
- A global cap of **512 captured examples** bounds memory for the full session. Once an event or session reaches its cap, further occurrences are still counted but their arguments are not sampled.
- Samples are buffered and sent by `/apidocs flush` or `/apidocs stop` as `snapshot/event-watch` records, in chunks rather than a file per callback.
- The current broad-watch snapshot format is `api-event-watch-v3`. When
  context is enabled, relevant selected events have bounded `context.*`
  getter observations; all earlier `v2` snapshots remain valid historical evidence.
- After a successful `/apidocs stop`, the next collection session starts
  with fresh per-event sampling quotas.
- Chat-related events (`CHAT_*`, `ACTIVATE_CHAT_*`, `COMMAND`, and `EMOTE_ENTERED`) use **the same bounded local argument previews** as other events: real table keys, nested field types, and example values are captured. New chat samples include `argN schema=...` metadata; broad-watch `shape=...` fingerprints expose table keys and nested types. The local `captures/` directory therefore contains actual message contents and should remain private.
- Reports automatically published to the **public** GitHub repository preserve chat event names, argument types/counts, table field names/nesting/types and numeric/boolean examples. The report generator omits chat message strings and chat table value previews, including inside event-watch snapshot records. Historical captures made under the old type-only recorder cannot retroactively yield missing table keys.
- `/apidocs watch EVENT_NAME` is **optional**, for a particularly noisy, rare, or complex event when automatic samples are insufficient. It is no longer required for basic table field discovery.

The event list is based on documentation last edited in March 2024. It includes events which might have been removed or which require rare circumstances; not observing an event is **not** proof that it is absent.

## Sample snapshot format

Earlier enhanced observations emitted `format=api-event-watch-v2`; new sessions emit `api-event-watch-v3`, with an additional `shape=` field. One event can produce multiple samples with **the same argument-type signature** when the values or table layout change.

~~~text
format=api-event-watch-v2
source=historical-event-candidates
candidate_count=214
observed_events=2
part=1
signature=1:table
occurrences=3
shape=table{"destination":string}
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{["destination"]="Sedina" (bytes=6)}

---
signature=1:table
occurrences=3
shape=table{"destination":string}
event=NAVROUTE_CHANGED
arguments=1
arg1 type=table value=table{["destination"]="Bractus" (bytes=7)}
~~~

These examples illustrate the format only: those exact `NAVROUTE_CHANGED` table values have **not** yet been observed in VO. The `occurrences` number is a total event count, not a per-example count. The older `api-event-watch-v1` captures remain useful but do not contain changing-value samples.

## Git handoff and retention

The local collector saves raw snapshots in `captures/` (Git-ignored). `tools/share-observations.pl --push` publishes **only captures newer than the current reviewed-through marker**, in one temporary Markdown report. After review, maintainers consolidate findings in permanent reference pages, advance `data/reviewed-through.txt` and delete the temporary report from the current branch. Git history still contains prior versions and must not be treated as secure deletion.
