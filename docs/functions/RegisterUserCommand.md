# RegisterUserCommand

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `RegisterUserCommand(string commandname, func callback(dataarg, {arguments1, ..}), data) -> nil`

## Historical description

hook up object to command

### Arguments named by the historical source

- commandname string containing the command
- callback function accepting two arguments to run when command is executed
- dataarg see data
- arguments1 arguments of the command (Note: if there are no arguments the table is nil not an empty table.)
- data data to pass callback

### Historical illustrative example (unverified)

Racecar gives this example; it is **not an observed result from our client**.

`-- function to call when the command is entered local function printfunc(data, args) -- data contains the third parameter of RegisterUserCommand local str = tostring(data) -- if the command was entered without parameters args i...`

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_RegisterUserCommand) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
