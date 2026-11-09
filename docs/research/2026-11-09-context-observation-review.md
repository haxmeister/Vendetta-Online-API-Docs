# Fourth batch: first context-enabled event observations (2026-11-09 UTC)

**Source:** `20261109T004719.408544Z-25087-000001.txt`, `api-event-watch-v3`, latest capture timestamp `20261109T004719.408544Z`.

- **84** saved examples, **58** distinct event names, **31** samples with callback-time getter context (17 event names).
- **One newly observed name:** `PLAYER_HOME_CHANGED`. Total observed name coverage is **69/214**.
- No function-inspection records or standalone event records were in this handoff.
- Findings were extracted into [individual event pages](../events/index.md) and the [fourth survey](../events/2026-11-09-context-live-event-survey.md).
- Chat payloads and context string values were redacted. Contextual matches are evidence of correlation, not guaranteed argument semantics.
- A later maintainer action advances `data/reviewed-through.txt` and deletes the temporary report from the current Git tree; prior Git commits retain old versions.
