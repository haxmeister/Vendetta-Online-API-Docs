# PLAYER_DEATH_CINEMATIC_FINISHED

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument meaning provisional.

## Arguments

**Observed callback form:** `()`. Positions exclude the event name passed to `OnEvent(event, ...)`.

No positional callback arguments were observed.

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

---

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Saved examples:** 1. **Argument signature(s):** `0:`.

### Captured examples

~~~text
signature=0:
shape=
event=PLAYER_DEATH_CINEMATIC_FINISHED
arguments=0
~~~

### Interpretation

No additional arguments were delivered in the single recorded callback; other contexts remain untested.

**Occurrence-count caveat:** Event counters persist across flushes; do not sum these counts with previous snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — November 9, 2026 UTC

**Callbacks:** 1. **Saved examples:** 1.
**Type signature(s):** `0:`.

~~~text
event=PLAYER_DEATH_CINEMATIC_FINISHED
arguments=0
~~~

### Interpretation

A numeric callback value was observed where shown; its identity and relation to specific players has not been independently checked.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).
