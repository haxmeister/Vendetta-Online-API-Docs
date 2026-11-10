# Racecar function and table archive — November 10, 2026

**Evidence:** User-provided offline `Racecar_Documentation_Archive(1).zip`,
not a new observation from a running Vendetta Online client.

## Inventory

The supplied archive contains **715 saved wiki pages**, each with HTML and
a readable text counterpart, plus source-URL metadata in `manifest.json`.
Its capture time is recorded as November 10, 2026 UTC. The supplied
manifest lists **one unsuccessful retrieval** (a Special Pages URL),
**242 historical red links**, and no unattempted discoveries.
An archived copy of Racecar `API_Index` and the later `API_Index2`
are included. The archived pages frequently have considerably earlier edit
dates (2009–2016). The public reference should not equate the archive's
capture time with the wiki content's original revision date.

The resulting reference includes:

| Section | Pages | Evidence |
| --- | ---: | --- |
| [Functions](../functions/index.md) | 584 | 390 distinct names in Index2, plus 194 additional individual legacy pages |
| [Tables and libraries](../tables/index.md) | 63 | Racecar Index2 names; 26 have an associated archived detail page and 37 have only index-level information |
| [Variables](../variables/index.md) | 11 names | Historical Index2 values only |
| [Live-tested getter overview](../functions/observed-getters.md) | 12 functions | Independent observations from November 8–9, 2026 |

Only **12 functions** have invocation-and-return evidence in this project so far.
The November 8 accessibility survey checked 398 candidate names, but did not
exercise their signatures. Do not describe that survey as a live functional
test of the historical API. **Six function reference names lack individual
archived detail pages** and rely on index-level information.

## Important discrepancies and additions

- **`GetActiveShipHealth()`**: Racecar's individual page describes ten
  positions, ending in optional current and maximum shield values. Its
  summary in Index2 lists eight. Live testing returned ten positions,
  with both shield-like positions `nil` in the sampled ship; an earlier
  no-active-ship callback returned zero positions. The candidate meaning
  of each position remains provisional.
- **`GetTargetInfo()`**: Historical individual-page return labels describe
  six fields. Our live client returned seven values when targeting ships
  or asteroids, and zero return values without a target. The extra
  seventh position was `nil` in tested samples.
- **`GetTargetDistance()`**: Historical one-number description does not
  capture the two-position return observed live (`number, nil` or
  `nil, nil`).
- **`GetActiveShipSpeed()`**: Index2 calls its return an integer; the
  live client returned fractional speed values.
- **`CreateCharacter()`**: The historical individual-page signature
  names the first argument `string name`, while Index2 describes it as
  `int name`. Neither claim has been confirmed by a live invocation;
  this action should not be probed merely to settle the difference.
- **`GetLastShipLoadout()`**: The individual page mentions an
  `overlayindex` field not shown in the short Index2 description.
  Its present-day shape has not been inspected.
- **`SendChat()`**: The detailed page lists historical destination
  strings such as `PRIVATE`, `GROUP`, `GUILD`, and `CHANNEL`,
  and explains use of `dstparam`. These labels are historical leads,
  not direct observations of currently accepted destinations.
- **`NavRoute`, `Guild`, `Game`, `Timer`, `TCPSocket`**:
  individual pages enumerate methods and in some cases behavior that
  Index2 omits. Their documented methods should be checked against
  current Lua table values in a later **read-only** inspection.
- **Structured return notation**: A historical signature that embeds
  `{ int price, string icon }` does not itself prove that a returned
  Lua table has keys named `price` and `icon`; it could describe
  positional values. Keep such names as unverified field labels.

## Precedence and current limitations

1. **Live client observations** govern captured counts, types, values, and
   table keys. Prior captures must not be overwritten by Racecar claims.
2. **Historical individual pages** provide richer explanations, typed
   parameters and examples, but are not proof they still work.
3. **Racecar Index2** is the more recent historical summary; individual
   pages may disagree with it. Preserve both when useful.
4. **Older Racecar Index / extra detail pages** supply additional names
   that may be obsolete; these are labeled legacy-only.
5. **No invented examples**: a historical example is labeled historical;
   an observed value must come from real client capture.

The original uploaded archive is not copied into the repository. We retain
derived reference entries, factual field names, short historical descriptions,
and attribution links instead of a wholesale HTML mirror.

**Source:** [Racecar API Index2](https://www.vo-wiki.com/racecar2/index.php/API_Index2).
See [our documentation evidence rules](../reference-conventions.md).
