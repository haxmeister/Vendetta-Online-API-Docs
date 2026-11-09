# Third live VO event survey — November 8–9, 2026 UTC

**Status:** Game-client observations. These are sampled callback arguments, not guaranteed API contracts.

The new capture handoff contained **two** `api-event-watch-v2` snapshots: `20261108T234315.893757Z-24651-000062.txt` and `20261109T000121.364994Z-24651-000114.txt`. Together they included **30 saved examples from 23 distinct event names**. Of those names, **14 had not appeared in our previous two reports**, increasing cumulative observed coverage to **68 of 214 historical event candidates**.

The watcher reported `observed_events=54` in its earlier flush and `observed_events=67` in its later flush. **Those are cumulative event counters in the running watcher**, not counts of distinct names newly documented in these two snapshots. Only events with *new saved examples* appear in the report, and their `occurrences` values cannot safely be added to totals from earlier flushes.

## First documented in this batch

- [`CHAT_MSG_CONFIRMATION`](CHAT_MSG_CONFIRMATION.md)
- [`CHAT_MSG_DEATH`](CHAT_MSG_DEATH.md)
- [`CHAT_MSG_PRINT`](CHAT_MSG_PRINT.md)
- [`CHAT_MSG_SECTOR`](CHAT_MSG_SECTOR.md)
- [`CHAT_MSG_SECTORD`](CHAT_MSG_SECTORD.md)
- [`CHAT_MSG_SECTORD_MISSION`](CHAT_MSG_SECTORD_MISSION.md)
- [`CHAT_MSG_SERVER`](CHAT_MSG_SERVER.md)
- [`INVENTORY_ADD`](INVENTORY_ADD.md)
- [`INVENTORY_REMOVE`](INVENTORY_REMOVE.md)
- [`MSG_LOGOFF_TIMER`](MSG_LOGOFF_TIMER.md)
- [`NAVROUTE_ADD`](NAVROUTE_ADD.md)
- [`PLAYER_DEATH_CINEMATIC_FINISHED`](PLAYER_DEATH_CINEMATIC_FINISHED.md)
- [`PLAYER_DIED`](PLAYER_DIED.md)
- [`SHIP_CHANGED`](SHIP_CHANGED.md)

## Event examples captured in this batch

| Event | Samples | Observed signature(s) | Example argument values |
| --- | ---: | --- | --- |
| [`CHAT_MSG_CONFIRMATION`](CHAT_MSG_CONFIRMATION.md) | 1 | `1:table` | Chat values redacted |
| [`CHAT_MSG_DEATH`](CHAT_MSG_DEATH.md) | 1 | `1:table` | Chat values redacted |
| [`CHAT_MSG_PRINT`](CHAT_MSG_PRINT.md) | 1 | `1:table` | Chat values redacted |
| [`CHAT_MSG_SECTOR`](CHAT_MSG_SECTOR.md) | 1 | `1:table` | Chat values redacted |
| [`CHAT_MSG_SECTORD`](CHAT_MSG_SECTORD.md) | 1 | `1:table` | Chat values redacted |
| [`CHAT_MSG_SECTORD_MISSION`](CHAT_MSG_SECTORD_MISSION.md) | 1 | `1:table` | Chat values redacted |
| [`CHAT_MSG_SERVER`](CHAT_MSG_SERVER.md) | 1 | `1:table` | Chat values redacted |
| [`CINEMATIC_START`](CINEMATIC_START.md) | 1 | `0:` | No extra arguments |
| [`CONQUERED_SECTORS_UPDATED`](CONQUERED_SECTORS_UPDATED.md) | 4 | `1:table` | table{[20]=true, [22]=true} / table{[30]=true} |
| [`DESIRED_SPEED_CHANGED`](DESIRED_SPEED_CHANGED.md) | 1 | `0:` | No extra arguments |
| [`INVENTORY_ADD`](INVENTORY_ADD.md) | 2 | `1:number` | 14163 / 14165 |
| [`INVENTORY_REMOVE`](INVENTORY_REMOVE.md) | 2 | `1:number` | 9066 / 9101 |
| [`INVENTORY_UPDATE`](INVENTORY_UPDATE.md) | 1 | `1:number` | 13304 |
| [`MISSIONLIST_UPDATED`](MISSIONLIST_UPDATED.md) | 1 | `1:number` | 3 |
| [`MSG_LOGOFF_TIMER`](MSG_LOGOFF_TIMER.md) | 2 | `1:string` | "10 seconds to self-destruct." (bytes=28) / "9 seconds to self-destruct." (bytes=27) |
| [`NAVROUTE_ADD`](NAVROUTE_ADD.md) | 1 | `1:number` | 5076 |
| [`NAVROUTE_CHANGED`](NAVROUTE_CHANGED.md) | 1 | `1:table` | table{[1]=4764} |
| [`PLAYER_DEATH_CINEMATIC_FINISHED`](PLAYER_DEATH_CINEMATIC_FINISHED.md) | 1 | `0:` | No extra arguments |
| [`PLAYER_DIED`](PLAYER_DIED.md) | 1 | `4:number,number,number,number` | 345929; 345929; 0; 4764 |
| [`PLAYER_UPDATE`](PLAYER_UPDATE.md) | 1 | `1:number` | 462219 |
| [`SHIP_CHANGED`](SHIP_CHANGED.md) | 2 | `1:number` | 9062 / 9100 |
| [`SHIP_UPDATED`](SHIP_UPDATED.md) | 1 | `1:number` | 9062 |
| [`TRANSACTION_COMPLETED`](TRANSACTION_COMPLETED.md) | 1 | `1:number` | 6 |

## Findings

- **`CINEMATIC_START`** now has a **zero-argument observation**, besides the previously seen one-boolean and one-number forms.
- **`MISSIONLIST_UPDATED`** now delivered one numeric argument, `3`; previous observations yielded one explicit `nil`. Neither is equivalent to zero arguments.
- **`CONQUERED_SECTORS_UPDATED`** table samples included `{[20]=true, [22]=true}`, `{[30]=true}`, `{[6]=true, [8]=true}` and `{[6]=true}`. Key meanings remain unknown.
- **`NAVROUTE_CHANGED`** yielded `table{[1]=4764}`, adding another concrete route-table example.
- **`PLAYER_DIED`** delivered four numbers: `(345929, 345929, 0, 4764)`. Their semantics are not established.
- **`MSG_LOGOFF_TIMER`** supplied a countdown message as one string argument, including `"10 seconds to self-destruct."` and `"9 seconds to self-destruct."`.
- **`INVENTORY_ADD`, `INVENTORY_REMOVE`, `SHIP_CHANGED`, `SHIP_UPDATED`** all supplied numeric arguments; meanings require investigation.
- The repeated **398-name function inventory** matched the prior recorded type/status survey exactly. This checks type accessibility, **not function behavior or signatures**.

## Limits of the report

A saved example is not every callback. The watcher limits types/shapes and values, truncates large tables, and redacts chat payloads. It does not preserve individual callback timing or frequency of each example. Each event has an [individual reference page](index.md) with the concrete captured examples; unknown argument semantics remain marked as provisional.

**Other reports:** [First event survey](2026-11-08-live-event-survey.md) · [Second event survey](2026-11-08-second-live-event-survey.md).
