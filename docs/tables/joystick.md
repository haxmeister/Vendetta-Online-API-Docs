# joystick

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

functions to change joystick settings

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `GetJoystickAxisBind` | `GetJoystickAxisBind(joyindex, axisindex) -> ?` | Not documented |
| `GetJoystickAxisInvert` | `GetJoystickAxisInvert(joyindex) -> ?` | Not documented |
| `GetJoystickData` | `GetJoystickData(int joyindex) -> table joyinfo` | Not documented |
| `GetJoystickNumAxes` | `GetJoystickNumAxes(joyindex) -> ?` | Not documented |
| `GetJoystickNumButtons` | `GetJoystickNumButtons(joyindex) -> ?` | Not documented |
| `GetJoystickNumPOVs` | `GetJoystickNumPOVs(joyindex) -> ?` | Not documented |
| `GetJoystickSingleAxisCenter` | `GetJoystickSingleAxisCenter(joyindex, axisindex) -> ?` | Not documented |
| `GetJoystickSingleAxisDeadZone` | `GetJoystickSingleAxisDeadZone(joyindex, axisindex) -> ?` | Not documented |
| `GetJoystickSingleAxisInvert` | `GetJoystickSingleAxisInvert(joyindex, axisindex) -> ?` | Not documented |
| `GetJoystickSingleAxisRawValue` | `GetJoystickSingleAxisRawValue(joyindex, axisindex) -> int value` | Not documented |
| `GetJoystickSingleAxisSaturation` | `GetJoystickSingleAxisSaturation(joyindex, axisindex) -> ?` | Not documented |
| `GetJoystickSingleAxisSettings` | `GetJoystickSingleAxisSettings(joyindex, axisindex) -> ?` | Not documented |
| `GetJoystickSingleAxisValue` | `GetJoystickSingleAxisValue(joyindex, axisindex) -> int value` | Not documented |
| `GetJoystickSingleButtonValue` | `GetJoystickSingleButtonValue(joyindex, buttonindex) -> int buttonstate` | Not documented |
| `GetJoystickSinglePOVValue` | `GetJoystickSinglePOVValue(joyindex, povindex) -> ?` | Not documented |
| `ScanForJoysticks` | `ScanForJoysticks() -> nil` | Detects connected joysticks |
| `SetJoystickSingleAxisCenter` | `SetJoystickSingleAxisCenter(joyindex, axisindex, value) -> nil` | Not documented |
| `SetJoystickSingleAxisDeadZone` | `joystick.SetJoystickSingleAxisDeadZone(joyindex, axisindex, leftdeadzone, rightdeadzone) -> nil` | Not documented |
| `SetJoystickSingleAxisInvert` | `SetJoystickSingleAxisInvert(joyindex, axisindex) -> ?` | Not documented |
| `SetJoystickSingleAxisSaturation` | `joystick.SetJoystickSingleAxisSaturation(joyindex, axisindex, leftsat, rightsat) -> nil` | Not documented |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Joystick)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
