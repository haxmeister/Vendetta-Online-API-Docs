# gksound

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

audio related functions

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `GKUnloadSound` | `GKUnloadSound()` | Unloads a sound when a sound is specified. |
| `GKLoadSound` | `GKLoadSound() -> boolean` | Load an audio file and assign it to a sound effect name to be played by GKPlaySound. Files supported: wav, ogg, raw. When loading raw files, be sure to... |
| `GKPlaylist` | `GKPlaylist(string playlist) -> nil` | Play playlist file as background music. |
| `GKPlayMusic` | `GKPlayMusic(string filename, boolean loop, forceplay, number looppoint, volume) -> nil` | Playback the provided file as background music in a loop |
| `GKPlaySound` | `GKPlaySound(string soundeffect, float volume) -> nil` | Playback a soundeffect at the given volume |
| `GKStopMusic` | `GKStopMusic() -> nil` | Stop playing background music |
| `MuteSound` | `MuteSound(boolean mute) -> nil` | Set volume to level set with Gksound#SetSoundDuckingLevel |
| `GetSoundDuckingLevel` | `GetSoundDuckingLevel() -> float level` | Get volume level when receiving or sending voice chat |
| `SetSoundDuckingLevel` | `SetSoundDuckingLevel(float level) -> nil` | Set volume level when receiving or sending voice chat |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Gksound)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
