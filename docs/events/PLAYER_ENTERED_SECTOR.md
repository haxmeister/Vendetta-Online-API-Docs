# PLAYER_ENTERED_SECTOR

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

## Arguments

**Observed callback form:** `(number)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `number` | Not identified | `345929`, `883607` | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar describes the event as reporting players/NPCs in the current sector, including initial entrants when the client enters a sector.

**Historical argument descriptions:** Its old account suggests character IDs and a possible initial `0` marker or multi-value sequence during the initial population listing.

**Live evidence takes precedence for observed cases:** Our captures showed one numeric argument in the sampled callbacks. The older initial-entry/multi-value behavior has not been reproduced; do not present it as a verified callback signature.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149), last edited March 19, 2024. These claims are not live verification.


---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 17. **Observed argument type(s):** (`number`).
**Captured example(s):** `(30444115)`.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 120 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `1:number`.

### Recorded examples

~~~text
shape=number
event=PLAYER_ENTERED_SECTOR
arguments=1
arg1 type=number value=345929
~~~

~~~text
shape=number
event=PLAYER_ENTERED_SECTOR
arguments=1
arg1 type=number value=883607
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

**Callbacks:** 300. **Saved examples:** 2.
**Type signature(s):** `1:number`.

~~~text
event=PLAYER_ENTERED_SECTOR
arguments=1
arg1 type=number value=30460274
~~~

~~~text
event=PLAYER_ENTERED_SECTOR
arguments=1
arg1 type=number value=30460275
~~~

### Interpretation

A numeric callback value was observed where shown; its identity and relation to specific players has not been independently checked.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md).

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. Cumulative watcher occurrence counters are not independent event frequencies across flushes.

~~~text
signature=1:number
shape=number
event=PLAYER_ENTERED_SECTOR
arguments=1
arg1 type=number value=30465805
~~~

~~~text
signature=1:number
shape=number
event=PLAYER_ENTERED_SECTOR
arguments=1
arg1 type=number value=345929
~~~

The one-number callback appeared with new examples 30465805 and 345929. The number's precise identifier semantics are still provisional.

**Source:** [Fifth live survey](2026-11-09-fifth-live-event-survey.md), `20261109T013130.298625Z-25441-000001.txt`. Identifier meanings remain provisional.
