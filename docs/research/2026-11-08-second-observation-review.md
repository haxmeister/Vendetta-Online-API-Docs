# Second November 8, 2026 observation batch — reviewed

**Evidence:** 60 getter-inspection records and one `api-event-watch-v2` snapshot (`20261108T233831.046307Z-24651-000061.txt`).

- 12 getters × five calls: 60 successful calls; no Lua errors recorded.
- 52 event names, 65 stored event examples, and 569 callback deliveries.
- 12 event names first observed in this session, yielding 54 distinct observed names across the two sessions.
- Concrete table examples extracted for `NAVROUTE_CHANGED` and `CONQUERED_SECTORS_UPDATED`; six arguments recorded for `PLAYER_GOT_HIT` and three for `TARGET_SCANNED`.

**Permanent references:** [individual events](../events/index.md), [second event survey](../events/2026-11-08-second-live-event-survey.md), and [getter observations](../functions/observed-getters.md).

The raw source files remain local in `captures/`. The temporary handoff is removed from the current branch after promotion. The reviewed cutoff is advanced to `20261108T233831.046307Z`; Git history retains older versions of previously committed reports.
