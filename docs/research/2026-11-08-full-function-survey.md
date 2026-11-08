# Function-name accessibility survey — November 8, 2026

**Status:** Observed in a running Vendetta Online client; not signature-tested.

**Input:** Three APIProbe captures from 2026-11-08 at 21:08:34 UTC:
- `20261108T210834.780964Z-22772-000001.txt` — part 1, 150 names
- `20261108T210834.781236Z-22772-000002.txt` — part 2, 150 names
- `20261108T210834.781357Z-22772-000003.txt` — part 3, 98 names

**Candidate source:** Historical Racecar2 Function Index combined with earlier curated candidates. This list includes Lua standard-library names and names defined by game code or plugins. It is not proof that all names are native Vendetta Online APIs.

## Results

| Observed type / status | Count |
| --- | ---: |
| `function` | 388 |
| `inaccessible` | 7 |
| `table` | 2 |
| `userdata` | 1 |
| **Total** | **398** |

Every name appears exactly once; parts 1, 2, and 3 are complete.

## Inaccessible names

- `GetCharInfo`
- `GetCurrentCharId`
- `GetCurrentStationid`
- `GetPlayerID`
- `GetSectorName`
- `StrTableStopTutorial`
- `deviceByMode`

`inaccessible` means the protected lookup failed. It can indicate an absent, restricted, or incorrectly spelled name; it is not proof of removal.

## Other observed values

- `TCPSocket`: `table`
- `iup`: `table`
- `rmlui`: `userdata`

One notable case difference: `GetCurrentStationID` is a function, while `GetCurrentStationid` is inaccessible. `GetCharacterInfo` is a function, while `GetCharInfo` is inaccessible. These do not establish equivalence or aliasing.

## Machine-readable records

See [`data/observations/2026-11-08-function-types.tsv`](../../data/observations/2026-11-08-function-types.tsv).

## Interpretation and next work

These probes read values but do not invoke functions. They cannot validate parameter names, argument types, return types, side effects, or safety. The historical reference is a useful candidate source but its signatures remain unverified. Validate representative read-only APIs and observe event payloads separately before publishing behavior as confirmed.
