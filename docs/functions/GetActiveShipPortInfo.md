# GetActiveShipPortInfo

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetActiveShipPortInfo(int portid) -> table portinfo`

## Historical description

returns information about the given port

### Arguments named by the historical source

- portid portid

### Returns named by the historical source

- portinfo table with port info
- fields include:
- type: int holding the type of port
- name string describing port
- position: vector with port position on ship
- orientation: quaternion holding orientation of port

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`GetActiveShipPortInfo(1) -> {type=4 name="PowerCell" position=(0, 0, 0) orientation=(0.000 0.000 0.000 1.000)}`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetActiveShipPortInfo) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
