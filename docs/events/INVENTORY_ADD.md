# INVENTORY_ADD

**Status:** Observed in the third collection batch (November 8–9, 2026 UTC); argument semantics provisional.

## Arguments

**Observed callback form:** `(number)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `number` | Not identified | `14163`, `14165` | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar associates the event with adding an inventory item.

**Historical argument information:** It names one position `itemid`, the identifier of the added item. Our live client delivered one number, consistent with that claim, but its identity has not been independently verified.

**Evidence priority:** Observed arguments and types above take precedence over historical naming. No extra arguments or fields are inferred.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149); last edited March 19, 2024.


---

## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

---

## New observations — third collection batch (November 8–9, 2026 UTC)

**Stored examples:** 2. **Argument signature(s):** `1:number`.

### Recorded examples

~~~text
signature=1:number
shape=number
event=INVENTORY_ADD
arguments=1
arg1 type=number value=14163
~~~

~~~text
signature=1:number
shape=number
event=INVENTORY_ADD
arguments=1
arg1 type=number value=14165
~~~

### Interpretation

The callback supplied a numeric value. Observed examples were `14163` and `14165`. Whether they are item IDs or another identifier has not been confirmed.

**Occurrence-count caveat:** The observer's event counters persist between flushes. Totals reported with these samples are cumulative, not counts to add to earlier snapshots.

**Source:** [Third event survey](2026-11-08-third-live-event-survey.md), snapshot `20261109T000121.364994Z-24651-000114.txt`.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 4. **Saved examples:** 2. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=1:number
shape=number
event=INVENTORY_ADD
arguments=1
arg1 type=number value=14168
~~~

~~~text
signature=1:number
shape=number
event=INVENTORY_ADD
arguments=1
arg1 type=number value=14169
~~~

### Interpretation and limitations

Two numeric examples were recorded (`14168`, `14169`). They may identify changed inventory objects, but we do not have simultaneous lookup results to confirm.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. Event occurrence counters remain cumulative across flushes, and are not per-example frequencies.

~~~text
signature=1:number
shape=number
event=INVENTORY_ADD
arguments=1
arg1 type=number value=14172
~~~

~~~text
signature=1:number
shape=number
event=INVENTORY_ADD
arguments=1
arg1 type=number value=14173
~~~

New numeric examples were 14172 and 14173; whether these are item identifiers is not established.

Examples are not constants or complete schemas; callback-time getter context may reflect transitional state. [Fifth survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013730.312126Z-25441-000003.txt`.
