# GUILD_MEMBER_ADDED

**Status:** Historical event name; no callback observations recorded yet.

## Arguments

**Not yet observed.** No live callback has been captured, so the argument count, Lua types, meanings, and example values are all **unknown**.

To investigate this historical candidate, use the event watcher while performing the relevant in-game action:

~~~text
/apidocs watch GUILD_MEMBER_ADDED
~~~

## Historical Racecar reference (March 2024)

**Historical description:** Racecar says this fires when a guild member logs in or joins the guild.

**Historical argument information:** It proposes a character ID and numeric rank. Its historical ranks were `0` member, `1` lieutenant, `2` council, `3` both, and `4` commander. These codes have not been checked live.

**Evidence priority:** No live callback has been observed. The historical argument description is not an observed signature.

**Source:** [Racecar Eventtype, revision 14149](https://vo-wiki.com/racecar2/index.php?title=Eventtype&oldid=14149); last edited March 19, 2024.


## Sources

- [Historical event candidates](../../plugin/APIProbe/events.lua) (compiled from the March 2024 `Eventtype` reference).

