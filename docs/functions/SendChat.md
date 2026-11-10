# SendChat

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `SendChat(string msg, string dst, string dstparam) -> nil`

## Historical description

Send a message to the provided destination.

### Arguments named by the historical source

- msg the message
- dst destination
- known destinations:
- "SAY" sector chat
- "SECTOR" sector chat
- "STATION" station chat
- "PRIVATE" private chat. requires char parameter
- "CHANNEL" chat chat
- "SYSTEM" system chat
- "GROUP" group chat
- "GUILD" guild chat
- "MISSION" mission chat. to activate reply buttons in the mission log send numbers. where 1 correspondends to the top most button
- dstparam if dst = PRIVATE, the player to send the message, if dst = CHANNEL the channel to send the message (nil for current channel)

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`SendChat("Hi", "PRIVATE", "dude") -> nil`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_SendChat) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
