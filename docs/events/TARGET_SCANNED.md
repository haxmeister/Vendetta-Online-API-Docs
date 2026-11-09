# TARGET_SCANNED

**Status:** Observed for the first time in the second live collection session on November 8, 2026; signature provisional.

## Arguments

**Observed callback form:** `(string, number, number)`. Positions exclude the event name passed to `OnEvent(event, ...)`.

| Position | Lua type(s) | Meaning | Recorded example(s) | Meaning confidence |
| --- | --- | --- | --- | --- |
| 1 | `string` | Scan result text | `"Cargo Hold Empty"`, `"Ship too far to scan"` | High |
| 2 | `number` | Not identified | `3`, `10` | Unknown |
| 3 | `number` | Not identified | `1292`, `99` | Unknown |

**Evidence limit:** The Lua types and examples were captured live. Confidence describes the proposed meaning, not a guarantee about future game states.

## Historical Racecar reference (March 2024)

**Historical description:** Racecar describes a scan-result event that also updates the HUD scan-information display.

**Historical argument descriptions:** It names three positions `scaninfo`, `nodeid`, and `objectid`; it says `scaninfo` is the displayed scan-result text and may contain cargo, ore, or out-of-range messages.

**Live evidence:** The observed form `(string, number, number)` agrees with the historical three-position structure, and position 1 carried real scan messages. The two numeric identifier names are **historical claims only**, not confirmed by an independent comparison. Neither number matched the current target distance.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149), last edited March 19, 2024. These claims are not live verification.


---

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## Second live collection — November 8, 2026

**Callbacks:** 21 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `3:string,number,number`.

### Recorded examples

~~~text
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Cargo Hold Empty\
" (bytes=17)
arg2 type=number value=3
arg3 type=number value=1292
~~~

~~~text
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Ship too far to scan\
" (bytes=21)
arg2 type=number value=3
arg3 type=number value=1292
~~~

### What this tells us

The observed scan messages were “Cargo Hold Empty” and “Ship too far to scan”, with a terminating newline in each string, followed by the numbers `3` and `1292`. The numeric fields are not yet identified.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks in this session:** 19. **Saved examples:** 2. These are event-wide counts, not frequencies of each sample.

### Observed argument examples and getter context

~~~text
signature=3:string,number,number
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Ship too far to scan\
arg2 type=number value=10
arg3 type=number value=99
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:0.062409638554217,number:3690.9697912608,number:0,string,string,nil]
context.GetTargetDistance=2[number:3690.9697912608,nil]
~~~

~~~text
signature=3:string,number,number
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Ship too far to scan\
arg2 type=number value=10
arg3 type=number value=99
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:0.062409638554217,number:4027.6685563735,number:0,string,string,nil]
context.GetTargetDistance=2[number:4027.6685563735,nil]
~~~

### Evidence and interpretation

Both sampled callbacks delivered a message string plus numeric arguments **10 and 99**. Contextual target distances were **3690.9697912608** and **4027.6685563735**. Neither numeric event field represented that distance in these examples. The scan message in both samples was 'Ship too far to scan' with a line ending.

**Limitations:** Getter context was obtained inside the event callback; it does not establish pre-event state or callback ordering.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.

---

## Fifth live capture — November 9, 2026 UTC

**Saved examples:** 2. The watcher counts event occurrences cumulatively across flushes; they are not per-example frequencies.

~~~text
signature=3:string,number,number
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Ship too far to scan\
" (bytes=21)
arg2 type=number value=11
arg3 type=number value=842
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:1,number:1062.7273874329,number:3,string,string,nil]
context.GetTargetDistance=2[number:1062.7273874329,nil]
~~~

~~~text
signature=3:string,number,number
shape=string;number;number
event=TARGET_SCANNED
arguments=3
arg1 type=string value="Ship too far to scan\
" (bytes=21)
arg2 type=number value=11
arg3 type=number value=842
context=callback-time-approved-getters-v1
context.GetTargetInfo=7[string,number:1,number:1488.3341358714,number:3,string,string,nil]
context.GetTargetDistance=2[number:1488.3341358714,nil]
~~~

Both examples delivered `"Ship too far to scan"` (ending with a newline), followed by numbers 11 and 842. Target distance varied from approximately 1062.73 to 1488.33. Neither numeric event field was the contemporaneous distance.

Getter context was taken *during* the callback, so equal values are correlations rather than proof of a universal signature. [Fifth context survey](2026-11-09-fifth-live-event-survey.md), snapshots `20261109T013130.298625Z-25441-000001.txt`.
