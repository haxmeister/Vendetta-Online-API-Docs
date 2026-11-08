# Observed no-argument getters

**Status:** Behavior observed in a live Vendetta Online client, November 8, 2026. Signatures are *provisional*, not authoritative.

These 12 names were invoked by the explicit APIProbe inspection allowlist five times each. **All 60 calls succeeded**, but certain functions returned zero values or nils when their requested game state was unavailable. The five observation rounds covered no target (including one docked round), an asteroid target, and an NPC ship target at two distances.

[Reviewed capture batch](../research/2026-11-08-observation-review.md) · [Function-name inventory](../research/2026-11-08-full-function-survey.md)

The notation below describes **observed returns**, not arguments. Optional types are only those seen in these five samples. Calls with other game objects or contexts may differ.

| Function | Observed return signature | Evidence / interpretation |
| --- | --- | --- |
| `GetCurrentSectorid()` | `number` | Five numeric IDs; observed 4735 and 5597 |
| `GetCurrentSystemid()` | `number` | Five numeric IDs; observed 19 and 22 |
| `GetCurrentStationID()` | `number \| nil` | Numeric ID 1432833 in the one docked round; nil in four undocked rounds |
| `GetActiveShipName()` | `string` | Five string results; four later captures recorded `"EC-89"` |
| `GetActiveShipSpeed()` | `number` | Observed 0, ~0, 46.93 and 35.57; a value of `1.12e-17` shows floating-point noise at nominal zero |
| `GetActiveShipEnergy()` | `number, number` | Values appear to be energy amount and fraction (see below) |
| `GetActiveShipHealth()` | `number × 8, nil, nil` | Ten return positions every time; first eight numbers, two trailing nils (see below) |
| `GetTargetInfo()` | **0 values** without a target; **7 values** with a target | Return types depend on target category (see below) |
| `GetTargetDistance()` | `number \| nil, nil` | Always two positions; first numeric for a target, nil without one |
| `HasActiveShip()` | `boolean` | Returned `true` in all five rounds; false state untested |
| `PlayerInStation()` | `boolean` | Returned `true` only in the docked round |
| `IsStormPresent()` | `boolean` | Returned `false` in all five rounds; storm state untested |

## GetActiveShipEnergy()

The observed pairs were:

| Amount | Second value | Context |
| ---: | ---: | --- |
| 250 | 1 | First undocked round |
| 0 | 0 | Docked round |
| 250 | 1 | Undocked |
| 167.314743 | 0.669259 | Undocked |
| 236.689545 | 0.946758 | Undocked |

The second value tracks the first divided by **250** within the precision observed, suggesting `(current_energy, fraction_of_capacity)`. We have not established whether every ship has capacity 250 or whether the two values change with equipment.

## GetActiveShipHealth()

Every observation had **ten** return positions: eight numbers followed by two explicit nils. The first and seventh numbers were both `0` in one observation and `25` in the other four. Positions two through six were `0` throughout; the eighth was `6000` in all five.

A historical reference describes health fields, damage, and maximum health, but these captures **do not establish the meaning of every position**. In particular, do not infer health percentage or segment mapping from one ship.

## Target getters

### GetTargetInfo()

Without a target, the function returned **no values** (not a single `nil`) in two rounds.

When an asteroid was targeted, it returned seven positions:

```text
(string "Asteroid", nil, number distance, nil, nil, nil, nil)
```

When an NPC ship was targeted, it also returned seven:

```text
(string name, number 1, number distance, number 9, string "", string "Vulture", nil)
```

The observed NPC fields are *consistent with* the historical `(name, health, distance, faction, guild, ship, ...)` description. Field seven remained nil. Those field meanings require additional controlled comparisons.

### GetTargetDistance()

The function returned **two values** in every sample:

- Without target: `(nil, nil)`
- With target: `(number distance, nil)`

The first distance exactly matched the third value from `GetTargetInfo()` in all three targeted observations: approximately **1186.86**, **394.34**, and **96.69**. The second value's purpose is unknown.

## Next validation steps

1. Inspect `GetTargetInfo()` and `GetTargetDistance()` against an asteroid, NPC, player ship, and no target; record the exact number of return values.
2. Test `GetActiveShipEnergy()` with a different ship or battery to check whether 250 is an invariant or an observed capacity.
3. Test `GetActiveShipHealth()` at known different damage levels to identify the first eight numeric fields and the two trailing nils.
4. Observe `TARGET_CHANGED` and `SECTOR_CHANGED` events in-game; the current report contains only one `SECTOR_LOADED` event with zero arguments.

The inspector records observations from explicitly approved functions; it does not call arbitrary API names or validate behavior automatically.
