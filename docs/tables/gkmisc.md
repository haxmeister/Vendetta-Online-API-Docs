# gkmisc

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

misc functions ..

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `date` | `gkmisc.date([string format[, int time]]) -> string date` | Print formatted date; analogous to [1] . Same as Os#date but the year is shifted 2428 years forward (ingame date). Result varies depending on the client... |
| `DiffTime` | *Not specified* | Not documented |
| `chatfilter` | *Not specified* | Not documented |
| `strnatcasecmp` | `Natural Sort Order` | Human readable natural sort order for strings. Similar to strnatcmp(), except that the comparison is not case sensitive. For more information see: Marti... |
| `strnatcmp` | *Not specified* | Not documented |
| `GetGameTime` | *Not specified* | Similar to os.time(), but |
| `GKGetHostName` | *Not specified* | Not documented |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Gkmisc)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
