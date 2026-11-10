# ForEachPlayer

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `ForEachPlayer( function func) -> nil`

**Index2 summary:** `ForEachPlayer(function func(int charid)) -> nil`

## Historical description

calls func with the character id of each player in the sector. that includes bots and the sector thingy itself

### Arguments named by the historical source

- function — func — receives one argument from ForEachPlayer. func(number charid)
- charid = character id

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`ForEachPlayer(function (id) print(id) end)`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_ForEachPlayer) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
