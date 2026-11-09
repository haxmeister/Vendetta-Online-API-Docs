# Observed no-argument getters

**Status:** Behavior observed in a live Vendetta Online client, November 8, 2026. Signatures are *provisional*, not authoritative.

These 12 names were invoked in two five-round sessions and a third four-round session. **All 168 recorded calls succeeded**, but certain functions returned zero values or nils when their requested game state was unavailable. The initial five observation rounds covered no target (including one docked round), an asteroid target, and an NPC ship target at two distances.

[Reviewed capture batch](../research/2026-11-08-observation-review.md) · [Function-name inventory](../research/2026-11-08-full-function-survey.md)

The notation below describes **observed returns**, not arguments. The table contains initial-session examples; second-session examples follow below. Optional types are only those seen in these five samples. Calls with other game objects or contexts may differ.

| Function | Observed returns | Example values from the game | Context / caveat |
| --- | --- | --- | --- |
| `GetCurrentSectorid()` | number | `5597` | Current sector; also observed `4735` |
| `GetCurrentSystemid()` | number | `22` | Current system; also observed `19` |
| `GetCurrentStationID()` | number or nil | `1432833` (docked); `nil` (undocked) | Tested in one docked and four undocked rounds |
| `GetActiveShipName()` | string; also nil in callback context | `"EC-89"`; one `nil` at ship transition | Formal inspections returned strings; callback context also showed one nil |
| `GetActiveShipSpeed()` | number | `46.928863525391` | Also returned `0` at rest; tiny floating-point noise is possible |
| `GetActiveShipEnergy()` | number, number | `(167.31474304199, 0.66925895214081)` | Likely current energy and fraction; see examples below |
| `GetActiveShipHealth()` | ten positions (eight numbers, nil, nil), or zero values in callback context | `(25, 0, 0, 0, 0, 0, 25, 6000, nil, nil)` | Ten values with active ship; zero during a no-active-ship callback |
| `GetTargetInfo()` | no values without target; seven values with target | `("Asteroid", nil, 1186.8591428641, nil, nil, nil, nil)` | NPC ships returned different populated fields; see below |
| `GetTargetDistance()` | number or nil, nil | `(394.33755765207, nil)` | `(nil, nil)` when no target |
| `HasActiveShip()` | boolean | `true`, `false` | False was seen during ship-transition callback |
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

One observed call returned **`(25, 0, 0, 0, 0, 0, 25, 6000, nil, nil)`**. Every observation in the formal getter inspection rounds had **ten** return positions: eight numbers followed by two explicit nils. The first and seventh numbers were both `0` in one observation and `25` in the other four. Positions two through six were `0` throughout; the eighth was `6000` in all five.

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

## Second getter inspection session — November 8, 2026

Five additional calls were made for each getter (60 successes, no errors). The active ship was reported as `"Corvus Greyhound"`, whereas the earlier session reported `"EC-89"`. These samples show how actual return values change across ship and target states.

| Getter | New live examples |
| --- | --- |
| `GetActiveShipEnergy()` | `(250, 1)` |
| `GetActiveShipHealth()` | `(939, 0, 46, 80, 135, 0, 1200, 7500, nil, nil)` |
| `GetActiveShipName()` | `("Corvus Greyhound")` |
| `GetActiveShipSpeed()` | `(59.99732208252)`; `(57.883449554443)`; `(197.94502258301)`; plus 2 further examples |
| `GetCurrentSectorid()` | `(5656)`; `(5130)` |
| `GetCurrentStationID()` | `(nil)` |
| `GetCurrentSystemid()` | `(23)`; `(21)` |
| `GetTargetDistance()` | `(nil, nil)`; `(716.91092978835, nil)`; `(566.20940803734, nil)`; plus 2 further examples |
| `GetTargetInfo()` | `(no returned values)`; `("Ice Crystal", nil, 716.91092978835, nil, nil, nil, nil)`; `("Ice Crystal", nil, 566.20940803734, nil, nil, nil, nil)`; plus 2 further examples |
| `HasActiveShip()` | `(true)` |
| `IsStormPresent()` | `(false)` |
| `PlayerInStation()` | `(false)` |

### New ship-health example

Every call to `GetActiveShipHealth()` returned ten positions:

~~~text
(939, 0, 46, 80, 135, 0, 1200, 7500, nil, nil)
~~~

The earlier session recorded a different ship/state with `(25, 0, 0, 0, 0, 0, 25, 6000, nil, nil)`. The changing positions do not establish each field's meaning, but show why a single numerical example would be misleading.

### New target examples

- No target: `GetTargetInfo()` returned **zero values**, while `GetTargetDistance()` returned `(nil, nil)`.
- Ice Crystal: `GetTargetInfo()` returned `("Ice Crystal", nil, 716.91092978835, nil, nil, nil, nil)`, later at distance `566.20940803734`.
- Another ship: `GetTargetInfo()` returned `("A Murderous Hobo", 1, 645.20813017971, 1, "TGFT", "Behemoth", nil)`, later at distance `343.18653819752`.
- `GetTargetDistance()` matched the third `GetTargetInfo()` value in every targeted round.
- Energy was `(250, 1)` in each new observation; `GetCurrentStationID()` returned nil while `PlayerInStation()` was false in every new round.

**Evidence:** Five inspection rounds preceding event snapshot `20261108T233831.046307Z-24651-000061.txt` in the November 8 capture handoff.

## Third getter inspection session — November 8–9, 2026 UTC

Four additional inspection rounds produced **48 successful calls** (four per approved getter, no errors). They covered three readings from `"Corvus Marauder Mercenary"` and a later reading from `"Corvus Greyhound"`, including a docked state.

| Getter | New recorded example return values |
| --- | --- |
| `GetActiveShipEnergy()` | `(250, 1)`; `(0, 0)` |
| `GetActiveShipHealth()` | `(0, 0, 0, 0, 0, 0, 0, 10000, nil, nil)`; `(0, 0, 0, 0, 0, 0, 0, 7500, nil, nil)` |
| `GetActiveShipName()` | `("Corvus Marauder Mercenary")`; `("Corvus Greyhound")` |
| `GetActiveShipSpeed()` | `(3.2928614696059e-11)`; `(2.4891486167908)`; `(66.655891418457)`; plus 1 additional value |
| `GetCurrentSectorid()` | `(4764)`; `(5076)` |
| `GetCurrentStationID()` | `(nil)`; `(1299457)` |
| `GetCurrentSystemid()` | `(19)`; `(20)` |
| `GetTargetDistance()` | `(1575.5122976353, nil)`; `(311.23334543795, nil)`; `(281.22722129979, nil)`; plus 1 additional value |
| `GetTargetInfo()` | `("Asteroid", nil, 1575.5122976353, nil, nil, nil, nil)`; `("Asteroid", nil, 311.23334543795, nil, nil, nil, nil)`; `("*Marshal Vesella Slios", 1, 281.22722129979, 3, "", "Vulture", nil)`; plus 1 additional value |
| `HasActiveShip()` | `(true)` |
| `IsStormPresent()` | `(false)` |
| `PlayerInStation()` | `(false)`; `(true)` |

### Health results on the two ships

The observed `GetActiveShipHealth()` returns were ten positions each:

~~~text
Corvus Marauder Mercenary:
(0, 0, 0, 0, 0, 0, 0, 10000, nil, nil)

Corvus Greyhound:
(0, 0, 0, 0, 0, 0, 0, 7500, nil, nil)
~~~

Position eight varied between these ships; its meaning is not yet proven. The two trailing nil positions remain in all 14 cumulative inspections across three batches.

### Target and station context

- An asteroid target produced `("Asteroid", nil, 1575.5122976353, nil, nil, nil, nil)`, with a second reading at distance `311.23334543795`.
- A ship target produced `("*Marshal Vesella Slios", 1, 281.22722129979, 3, "", "Vulture", nil)`.
- With no target, `GetTargetInfo()` returned **zero values**, while `GetTargetDistance()` returned `(nil, nil)`. The other targeted distance values matched the third `GetTargetInfo()` position.
- In the final docked round, `PlayerInStation()` was `true`, `GetCurrentStationID()` returned `1299457`, and `GetActiveShipEnergy()` returned `(0, 0)`. This does not establish that docking always zeroes energy.

**Evidence:** Four getter inspection rounds in the third capture handoff. Samples are real values from the current game client, not constants.

## Next validation steps

1. Inspect `GetTargetInfo()` and `GetTargetDistance()` against an asteroid, NPC, player ship, and no target; record the exact number of return values.
2. Test `GetActiveShipEnergy()` with a different ship or battery to check whether 250 is an invariant or an observed capacity.
3. Test `GetActiveShipHealth()` at known different damage levels to identify the first eight numeric fields and the two trailing nils.
4. Compare the [live event survey](../events/2026-11-08-live-event-survey.md) with additional sector and target changes; both broad sessions have now observed 54 different events.

The inspector records observations from explicitly approved functions; it does not call arbitrary API names or validate behavior automatically.

## Fifth event session: callback-time getter results (November 9, 2026 UTC)

These results were sampled while events fired and are **not counted** among the 168 successful explicit getter inspections.

- With `HasActiveShip()=false`, `GetActiveShipName()` returned one nil and `GetActiveShipHealth()` returned **zero values** during `SHIP_CHANGED`. With an active ship, health returned ten positions, including trailing nils and eighth-position numbers 7500, 10000, and 20000.
- `GetTargetInfo()` returned zero values with no target, but seven positions with a target; `GetTargetDistance()` returned two positions, either `(nil,nil)` or a number and nil. A pair of target getters agreed on the distance `1492.4592959274` in one callback.
- Station context returned `PlayerInStation()=true` with IDs 1219585 and 1299457, and `false` with a nil station ID while leaving.
- Sector getters agreed with `SECTOR_CHANGED` callback arguments 4735 and 4764, and `PLAYER_DIED` fourth arguments 4780 and 5076. These are strong correlations, not universal contracts.

**Source:** [Fifth live context survey](../events/2026-11-09-fifth-live-event-survey.md). The getter runs during the callback; state transitions might still be underway.
