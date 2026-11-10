# gkini

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

functions to manipulate the games config file

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `ReadInt` | `ReadInt(string section, string key, int default) -> int value` | Read an integer from the given section and key |
| `ReadInt2` | *Not specified* | Not documented |
| `ReadString` | `ReadString(string section, string key, string default) -> string value` | Read a string from the given section and key |
| `ReadString2` | `ReadString2(string section, string key, string default, string file) -> string value` | Read a string from the given section and key, from any .ini file. |
| `WriteInt` | `WriteInt(string section, string key, int value) -> nil` | Write an integer to the given section and key |
| `WriteString` | `WriteString(string section, string key, string value) -> nil` | Write a string to the given section and key. The entire entry must be <= 767 characters in total, including the key, equals sign, and value. If the entr... |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Gkini)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
