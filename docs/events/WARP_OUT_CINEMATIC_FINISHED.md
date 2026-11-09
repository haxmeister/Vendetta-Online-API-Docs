# WARP_OUT_CINEMATIC_FINISHED

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

## Arguments

**Observed callback form:** `()`. Positions exclude the event name passed to `OnEvent(event, ...)`.

No positional callback arguments were observed.

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar associates the event with finishing the wormhole warp-out cinematic.

**Historical argument information:** The old account gives no argument shape. **Our live client observed a zero-argument callback**, which remains the authoritative observed signature.

**Evidence priority:** The live callback evidence in the Arguments section takes precedence if it differs from this historical statement.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149); last edited March 19, 2024.


---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 4. **Observed argument type(s):** none.
**Captured example(s):** `()`.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 8 (total for this event). **Saved examples:** 1.
**Observed argument-type signature(s):** `0:`.

### Recorded examples

~~~text
shape=
event=WARP_OUT_CINEMATIC_FINISHED
arguments=0
~~~

### What this tells us

These are representative values from a particular game state, not constants. The precise meaning of each field may require further testing.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## Fourth live session — November 9, 2026 UTC

**Callbacks:** 8. **Saved examples:** 1.
**Type signature(s):** `0:`.

~~~text
event=WARP_OUT_CINEMATIC_FINISHED
arguments=0
~~~

### Interpretation

The examples confirm the recorded callback argument count and type. No additional getter context was stored for these events.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).
