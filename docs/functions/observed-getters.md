# Observed no-argument getters

**Status:** Behavior observed in a live Vendetta Online client, November 8, 2026. Signatures are *provisional*, not authoritative.

These 12 names were invoked by the explicit APIProbe inspection allowlist five times each. **All 60 calls succeeded**, but certain functions returned zero values or nils when their requested game state was unavailable. The five observation rounds covered no target (including one docked round), an asteroid target, and an NPC ship target at two distances.

[Reviewed capture batch](../research/2026-11-08-observation-review.md) · [Function-name inventory](../research/2026-11-08-full-function-survey.md)

The notation below describes **observed returns**, not arguments. Optional types are only those seen in these five samples. Calls with other game objects or contexts may differ.

| Function | Observed returns | Example values from the game | Context / caveat |
| --- | --- | --- | --- |
| `GetCurrentSectorid()` | number | `5597` | Current sector; also observed `4735` |
| `GetCurrentSystemid()` | number | `22` | Current system; also observed `19` |
| `GetCurrentStationID()` | number or nil | `1432833` (docked); `nil` (undocked) | Tested in one docked and four undocked rounds |
| `GetActiveShipName()` | string | `"EC-89"` | Ship name in four recorded rounds |
| `GetActiveShipSpeed()` | number | `46.928863525391` | Also returned `0` at rest; tiny floating-point noise is possible |
| `GetActiveShipEnergy()` | number, number | `(167.31474304199, 0.66925895214081)` | Likely current energy and fraction; see examples below |
| `GetActiveShipHealth()` | eight numbers, nil, nil | `(25, 0, 0, 0, 0, 0, 25, 6000, nil, nil)` | Ten return positions; meanings of individual positions not established |
| `GetTargetInfo()` | no values without target; seven values with target | `("Asteroid", nil, 1186.8591428641, nil, nil, nil, nil)` | NPC ships returned different populated fields; see below |
| `GetTargetDistance()` | number or nil, nil | `(394.33755765207, nil)` | `(nil, nil)` when no target |
| `HasActiveShip()` | boolean | `true` | No observed `false` case yet |
| `PlayerInStation()` | boolean | `true` (docked), `false` (in space) | Confirmed against observed station ID |
| `IsStormPresent()` | boolean | `false` | Storm-present `true` case not yet tested |

**How to read these examples:** Parentheses group **multiple return values**, not a Lua table. Values are copied from actual captures, not arbitrary placeholders. When a function returns *zero values*, that is different from returning one `nil`. Actual identifiers, distances, health and energy change with game state; the examples are not constants.

## GetActiveShipEnergy()

For example, one live call returned `(167.31474304199, 0.66925895214081)`. The observed pairs were:

| Amount | Second value | Context |
| ---: | ---: | --- |
| 250 | 1 | First undocked round |
| 0 | 0 | Docked round |
| 250 | 1 | Undocked |
| 167.314743 | 0.669259 | Undocked |
| 236.689545 | 0.946758 | Undocked |

The second value tracks the first divided by **250** within the precision observed, suggesting `(current_energy, fraction_of_capacity)`. We have not established whether every ship has capacity 250 or whether the two values change with equipment.

## GetActiveShipHealth()

One observed call returned **`(25, 0, 0, 0, 0, 0, 25, 6000, nil, nil)`**. Every observation had **ten** return positions: eight numbers followed by two explicit nils. The first and seventh numbers were both `0` in one observation and `25` in the other four. Positions two through six were `0` throughout; the eighth was `6000` in all five.

A historical reference describes health fields, damage, and maximum health, but these captures **do not establish the meaning of every position**. In particular, do not infer health percentage or segment mapping from one ship.

## Target getters

### GetTargetInfo()

Without a target, the function returned **no values** (not a single `nil`) in two rounds.

When an asteroid was targeted, it returned seven positions:

```text
# Observed with an asteroid selected: seven return values
"Asteroid", nil, 1186.8591428641, nil, nil, nil, nil
```

When an NPC ship was targeted, it also returned seven:

```text
# Observed with an NPC ship selected: seven return values
"*Station Guard Cra-Ha Halina", 1, 394.33755765207, 9, "", "Vulture", nil
```

The observed NPC fields are *consistent with* the historical `(name, health, distance, faction, guild, ship, ...)` description. Field seven remained nil. Those field meanings require additional controlled comparisons.

### GetTargetDistance()

The function returned **two values** in every sample:

- Without target: **`(nil, nil)`**
- With an asteroid selected: **`(1186.8591428641, nil)`**
- With an NPC ship selected: **`(394.33755765207, nil)`** (also `(96.693292287715, nil)` at a shorter distance)

The first distance exactly matched the third value from `GetTargetInfo()` in all three targeted observations: approximately **1186.86**, **394.34**, and **96.69**. The second value's purpose is unknown.

## Next validation steps

1. Inspect `GetTargetInfo()` and `GetTargetDistance()` against an asteroid, NPC, player ship, and no target; record the exact number of return values.
2. Test `GetActiveShipEnergy()` with a different ship or battery to check whether 250 is an invariant or an observed capacity.
3. Test `GetActiveShipHealth()` at known different damage levels to identify the first eight numeric fields and the two trailing nils.
4. Compare the [live event survey](../events/2026-11-08-live-event-survey.md) with additional sector and target changes; the initial broad watch has now recorded 42 different events.

The inspector records observations from explicitly approved functions; it does not call arbitrary API names or validate behavior automatically.
