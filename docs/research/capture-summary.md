# Local VO API observations — sanitized summary

Generated from the user-provided `captures.tar` (November 8, 2026).
Raw captures remain local. This report omits returned string contents,
numerical values, error messages, event payloads, chat and notes.
It records function/event names and type signatures only.
Observations are not proof of universal signatures.

## Functions

| Function | Observed signature | Samples |
| --- | --- | ---: |
| GetActiveShipEnergy | ok: 2 returns (number, number) | 1 |
| GetActiveShipHealth | ok: 10 returns (number, number, number, number, number, number, number, number, nil, nil) | 1 |
| GetActiveShipName | ok: 1 returns (string) | 1 |
| GetActiveShipSpeed | ok: 1 returns (number) | 1 |
| GetCurrentSectorid | ok: 1 returns (number) | 1 |
| GetCurrentStationID | ok: 1 returns (nil) | 1 |
| GetCurrentSystemid | ok: 1 returns (number) | 1 |
| GetTargetDistance | ok: 2 returns (nil, nil) | 1 |
| GetTargetInfo | ok: 0 returns () | 1 |
| HasActiveShip | ok: 1 returns (boolean) | 1 |
| IsStormPresent | ok: 1 returns (boolean) | 1 |
| PlayerInStation | ok: 1 returns (boolean) | 1 |

## Events

| Event | Observed signature | Samples |
| --- | --- | ---: |
| SECTOR_LOADED | 0 args () | 1 |

## Coverage

- Function inspection records: 12
- Event observation records: 1
- Inventory snapshots and other raw captures are excluded.
