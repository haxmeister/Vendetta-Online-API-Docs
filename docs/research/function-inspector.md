# Controlled function inspector

**Status:** Implementation ready for a live VO test; results are not yet verified.

The 398-name function scan checked whether values were accessible. It did not
call functions or determine their return signatures. The inspector adds a
separate, opt-in way to sample some genuinely read-only getters.

## Approved getters

The following 12 argument-free game state functions are explicitly allowlisted
in `plugin/APIProbe/inspections.lua`:

| Function | Question to investigate |
| --- | --- |
| `GetCurrentSectorid` | Type of current sector identifier |
| `GetCurrentSystemid` | Type of current system identifier |
| `GetCurrentStationID` | Return behavior in and outside stations |
| `GetActiveShipHealth` | Number and types of ship-health return values |
| `GetActiveShipEnergy` | Ship energy return type |
| `GetActiveShipSpeed` | Ship speed return type |
| `GetActiveShipName` | Ship name type (text redacted) |
| `GetTargetInfo` | Number and types of target-information values |
| `GetTargetDistance` | Behavior with and without a target |
| `HasActiveShip` | Return type for active-ship state |
| `PlayerInStation` | Return type when docked/undocked |
| `IsStormPresent` | Return type for storm state |

This list reflects function names and historical descriptions, not an
independent assertion that every function is side-effect-free in all versions
of VO. No action functions (buy, sell, chat, launch, login, etc.) are included.
There are no supplied arguments. Unapproved names never run.

## Commands

Start the Linux::Event collector, then in VO:

~~~text
/apidocs connect
/apidocs inspect list
/apidocs inspect GetCurrentSectorid
/apidocs inspect GetActiveShipHealth
/apidocs inspect GetTargetInfo
/apidocs inspect all
~~~

`inspect list` only prints allowlisted names; it does not call them.
`inspect NAME` invokes one matching getter once.
`inspect all` invokes each approved getter once in order. Failures are
caught per getter; one call throwing an error does not prevent the others.

A successful record is stored at
`captures/function/GetCurrentSectorid/<timestamp>.txt` and looks like:

~~~text
format=api-inspect-v1
source=approved-no-arg
function=GetCurrentSectorid
result=ok
returns=1
return1 type=number value=123
~~~

Numbers are examples only, not actual observed values.

For an error (e.g. a target-dependent getter with no target):

~~~text
format=api-inspect-v1
source=approved-no-arg
function=GetTargetDistance
result=error
error="message from protected call"
~~~

## Data handling

- Each capture is produced on explicit command, never in the background.
- Lua's `pcall` catches ordinary Lua exceptions. It cannot protect against
  a native crash, which is why calls must stay allowlisted and read-only.
- The exact count of return values is saved; up to 24 positions are recorded,
  including explicit `nil` values.
- String results from approved getters are now recorded with their quoted
  contents (first 1024 bytes), original byte length, and a truncation marker
  when necessary. Earlier captures contain only lengths.
- Numeric and boolean values are included. Names, values and errors may reveal
  your in-game state or location, so review reports before public sharing.
- Table fields and userdata contents are not inspected.
- Error messages are quoted and limited to 240 bytes; they may still contain
  in-game details.
- The `share-observations.pl` report retains values and errors by default.
  Chat-related event payloads are redacted before inclusion, but the filter
  cannot recognize chat text copied into unrelated captures. Review the
  report before approving its publication to the public repository.

Next, inspect the same getters in different game states and compare their
return signatures with the historical descriptions. Do not mark a function's
return signature as verified based on one sample.
