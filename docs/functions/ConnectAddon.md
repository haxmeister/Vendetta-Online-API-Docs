# ConnectAddon

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ConnectAddon( number portid, number itemid [, function cb ]) -> boolean canconnect`

**Index2 summary:** `ConnectAddon(int portid, int itemid, function cb) -> bool canconnect`

## Historical description

Attaches the addon itemid to the active ship in port portid

### Arguments named by the historical source

- number — portid — portid of the the port
- number — itemid — itemid of the addon
- function — cb — function to call on completion (optional)

### Returns named by the historical source

- boolean — canconnect — returns true if the player is docked and has an active ship otherwise nil

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- put the addon 123 into port 2 while the player is docked to a station ConnectAddon(2, 123) -> true`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ConnectAddon) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
