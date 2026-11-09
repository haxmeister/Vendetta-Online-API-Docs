# MSG_NOTIFICATION

**Status:** Observed in two live collection sessions on November 8, 2026; signature provisional.

Event callbacks deliver the arguments listed below **after** the event name passed to `OnEvent(event, ...)`. `()` means zero arguments, while `(nil)` means one explicit nil.

## First live collection — November 8, 2026

**Callbacks:** 3. **Observed argument type(s):** (`string`, `number`, `boolean`, `boolean`).
**Captured example(s):** `("Press the Activate key to enter wormhole to Sedina.", 5000, false, false)`.

These are examples from the first broad-watch session, which preserved only one example per argument-type signature.

[First event survey](2026-11-08-live-event-survey.md).

## Second live collection — November 8, 2026

**Callbacks:** 8 (total for this event). **Saved examples:** 2.
**Observed argument-type signature(s):** `4:string,number,boolean,boolean`.

### Recorded examples

~~~text
shape=string;number;boolean;boolean
event=MSG_NOTIFICATION
arguments=4
arg1 type=string value="Press the Activate key to enter wormhole to Latos." (bytes=50)
arg2 type=number value=5000
arg3 type=boolean value=false
arg4 type=boolean value=false
~~~

~~~text
shape=string;number;boolean;boolean
event=MSG_NOTIFICATION
arguments=4
arg1 type=string value="Press the Activate key to enter wormhole to Sedina." (bytes=51)
arg2 type=number value=5000
arg3 type=boolean value=false
arg4 type=boolean value=false
~~~

### What this tells us

The observed message changed destination from Latos to Sedina. The accompanying arguments were `5000, false, false` in both samples, but their meanings have not been verified.

**Source:** [second event survey](2026-11-08-second-live-event-survey.md), snapshot `20261108T233831.046307Z-24651-000061.txt`.

## Evidence and limitations

- Historical event-name candidate: [events.lua](../../plugin/APIProbe/events.lua).
- Live observation: [second event survey](2026-11-08-second-live-event-survey.md).
- The broad observer keeps at most two example values per argument shape; the event callback count is not a per-example frequency.
- Table previews are intentionally bounded, and userdata is not traversed. Chat-related argument values are not recorded.

---

## Fourth live session — callback-time context (November 9, 2026 UTC)

**Callbacks:** 13. **Saved examples:** 2. Counts are event-wide, not per example.

### Callback examples

~~~text
signature=4:string,number,boolean,boolean
shape=string;number;boolean;boolean
event=MSG_NOTIFICATION
arguments=4
arg1 type=string value="Press the Activate key to enter wormhole to Latos." (bytes=50)
arg2 type=number value=5000
arg3 type=boolean value=false
arg4 type=boolean value=false
~~~

~~~text
signature=4:string,number,boolean,boolean
shape=string;number;boolean;boolean
event=MSG_NOTIFICATION
arguments=4
arg1 type=string value="\127ffffffPlease use a wormhole to continue on your flight route." (bytes=62)
arg2 type=number value=3000
arg3 type=boolean value=false
arg4 type=boolean value=false
~~~

### Interpretation and limitations

Two notification examples retained four arguments: message string, number, false, false. One included a wormhole instruction and numeric `5000`; another used numeric `3000` with a text-control prefix. These numeric values could have different meanings; the report doesn't establish them.

The context snapshot does not preserve per-callback timing or independent field verification.

**Source:** [Fourth live context survey](2026-11-09-context-live-event-survey.md), snapshot `20261109T004719.408544Z-25087-000001.txt`.
