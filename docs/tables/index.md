# Table reference

**63 historical table/library names** from Racecar Index2. Archived member descriptions are not proof of current Lua table layouts. `TCPSocket` was observed to have the Lua type `table` during the 2026 function name survey.

| Name | Evidence | Historical information |
| --- | --- | --- |
| [`_generalchatlog`](./_generalchatlog.md) | Historical; structure untested | array with chatlog |
| [`_missionlog`](./_missionlog.md) | Historical; structure untested | array with mission log |
| [`_stationlog`](./_stationlog.md) | Historical; structure untested | array with log of visisted stations |
| [`Bitlib`](./Bitlib.md) | Historical; structure untested | functions to manipulate the bitwise operations |
| [`Buddy`](./Buddy.md) | Historical; structure untested | functions to manipulate the characters buddylist |
| [`chatinfo`](./chatinfo.md) | Historical; structure untested | table with display options for each chat event |
| [`chatreceiver`](./chatreceiver.md) | Historical; structure untested | event handler for chat events |
| [`command_pretty_names`](./command_pretty_names.md) | Historical; structure untested | table that maps commands to their descriptions |
| [`coroutine`](./coroutine.md) | Historical; structure untested | coroutine class |
| [`debug`](./debug.md) | Historical; structure untested | debugging helpers |
| [`Duel`](./Duel.md) | Historical; structure untested | Duel related methods |
| [`FactionArticle`](./FactionArticle.md) | Historical; structure untested | table with faction articles. indices represent factionid. see: Article |
| [`FactionColor`](./FactionColor.md) | Historical; structure untested | table with faction colors. indices represent factionid |
| [`FactionColor_RGB`](./FactionColor_RGB.md) | Historical; structure untested | table that maps factionid's to colors in RGB format |
| [`FactionMonitor`](./FactionMonitor.md) | Historical; structure untested | table with monitoring types. indices represent numeric monitoring types and values, string representations of that type |
| [`FactionMonitorStr`](./FactionMonitorStr.md) | Historical; structure untested | table with monitoring types. values represent numeric monitoring types and indices, string representations of that type |
| [`FactionName`](./FactionName.md) | Historical; structure untested | Array with short names of the ingame faction |
| [`FactionNameFull`](./FactionNameFull.md) | Historical; structure untested | Array with long names of the ingame faction |
| [`FactionStanding`](./FactionStanding.md) | Historical; structure untested | table for mapping names of standing levels to it#s int value |
| [`FriendKeys`](./FriendKeys.md) | Historical; structure untested | taable friend key related functions |
| [`Game`](./Game.md) | Historical; structure untested | functions to control a few game features .. |
| [`GeneralChatPanel`](./GeneralChatPanel.md) | Historical; structure untested | table with parts of a chat area. seems to point to PDA or HUD chat panel depending on what is visible(?) |
| [`gkini`](./gkini.md) | Historical; structure untested | functions to manipulate the games config file |
| [`gkinterface`](./gkinterface.md) | Historical; structure untested | interface related functions.. |
| [`gkmisc`](./gkmisc.md) | Historical; structure untested | misc functions .. |
| [`gknet`](./gknet.md) | Historical; structure untested | network related functions |
| [`gksound`](./gksound.md) | Historical; structure untested | audio related functions |
| [`Group`](./Group.md) | Historical; structure untested | Group related functions |
| [`Guild`](./Guild.md) | Historical; structure untested | Guild related functions |
| [`Gunner`](./Gunner.md) | Historical; structure untested | Gunner related functions for multiplayer ships |
| [`gvector`](./gvector.md) | Historical; structure untested | gvector class. to create and manipulate vectors |
| [`HUD`](./HUD.md) | Historical; structure untested | HUD related functions |
| [`Ignore`](./Ignore.md) | Historical; structure untested | Ignorelist related functions |
| [`ignore_time`](./ignore_time.md) | Historical; structure untested | array with with ignored name and period entries |
| [`InvManager`](./InvManager.md) | Historical; structure untested | functions to get information about inventory items |
| [`joystick`](./joystick.md) | Historical; structure untested | functions to change joystick settings |
| [`Keychain`](./Keychain.md) | Historical; structure untested | keychain management |
| [`lcd`](./lcd.md) | Historical; structure untested | functions for the Logitech G-series keyboard screens |
| [`math`](./math.md) | Historical; structure untested | standard math library |
| [`math3d`](./math3d.md) | Historical; structure untested | functions to do some vector math |
| [`Mentor`](./Mentor.md) | Historical; structure untested | Mentor related functions |
| [`MissionLogPanel`](./MissionLogPanel.md) | Historical; structure untested | table with parts of the mission log |
| [`NavRoute`](./NavRoute.md) | Historical; structure untested | functions to manipulate your NavRoute |
| [`os`](./os.md) | Historical; structure untested | functions to interface with the operating system |
| [`quaternion`](./quaternion.md) | Historical; structure untested | quaternion class. to create and manipulate quats |
| [`radar`](./radar.md) | Historical; structure untested | functions to query and set radar parameters |
| [`ShipOrder`](./ShipOrder.md) | Historical; structure untested | table containing the ordering of ships in lists(?) |
| [`ShipPalette`](./ShipPalette.md) | Historical; structure untested | array that maps palette color values (1-256) to rgb values represented as gvectors |
| [`ShipPalette_string`](./ShipPalette_string.md) | Historical; structure untested | array that maps palette color values (1-256) to rgb values represented as strings |
| [`ShipPresets`](./ShipPresets.md) | Historical; structure untested | array with properties of ship presets |
| [`ShipSkinDescriptions`](./ShipSkinDescriptions.md) | Historical; structure untested | array containing livery descriptions |
| [`ShipSkinNames`](./ShipSkinNames.md) | Historical; structure untested | array containing livery names |
| [`Skills`](./Skills.md) | Historical; structure untested | table to translate skillid's into skill names and back |
| [`string`](./string.md) | Historical; structure untested | string manipulation functions |
| [`SystemNames`](./SystemNames.md) | Historical; structure untested | Table to translate systemid's into system names and back. |
| [`SystemNotes`](./SystemNotes.md) | Historical; structure untested | System Notes public table. Used for adding notes to the navmap. |
| [`table`](./table.md) | Historical; structure untested | standard table library |
| [`TagFuncs`](./TagFuncs.md) | Historical; structure untested | Text markup callbacks(?) |
| [`TCPSocket`](./TCPSocket.md) | Type observed as `table` | socket class |
| [`Thread`](./Thread.md) | Historical; structure untested | Thread library |
| [`Timer`](./Timer.md) | Historical; structure untested | Timer class |
| [`VoiceChat`](./VoiceChat.md) | Historical; structure untested | voice chat related functions |
| [`Vote`](./Vote.md) | Historical; structure untested | functions to use the voting feature |

## Interpretation

A function appearing as `function` in the November 2026 name scan proves only that the Lua value was accessible—not that its historical signature, arguments, or behavior are correct. [Read the evidence conventions](../reference-conventions.md).
