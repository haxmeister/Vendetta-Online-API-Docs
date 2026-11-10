# DisconnectAddon

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `DisconnectAddon(int itemid, function cb(int errorid)) -> bool ret1`

**Index2 summary:** `DisconnectAddon(int itemid) -> bool ret1`

## Historical description

detaches the addon itemid and stores it in the station Note: detached items will likely have a different itemid in the station

### Arguments named by the historical source

- itemid id of the item to detach
- cb function to call on completion (optional)
- errorid int corresponding to error, is nil if operation is successful

### Returns named by the historical source

- ret1 returns true if the player is docked and has an active ship otherwise nil

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`DisconnectAddon(123) -> true`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_DisconnectAddon) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
