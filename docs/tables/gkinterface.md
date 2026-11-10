# gkinterface

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

## Historical purpose

interface related functions..

## Historically documented members

Member names and signatures are transcribed as historical research leads, **not verified current APIs**.

| Member | Historical definition | Historical description |
| --- | --- | --- |
| `GetMouseLookMode/SetMouseLookMode` | *Not specified* | Not documented |
| `GetMouseOptions/SetMouseOptions` | *Not specified* | Not documented |
| `GetMousePosition` | `gkinterface.GetMousePosition() -> float percent_x, float percent_y` | Returns two floats which designate how far across the screen the mouse pointer is in percent, as seen from the top left. E.g., if the mouse pointer is d... |
| `GetMouseSensitivity/SetMouseSensitivity` | *Not specified* | Not documented |
| `SetMouseCursor` | *Not specified* | Not documented |
| `SetMouseCursorIndexImage` | *Not specified* | Not documented |
| `SetMouseHotspot` | *Not specified* | Not documented |
| `AddDirectionalLight` | *Not specified* | Not documented |
| `AddFXEffect` | *Not specified* | Not documented |
| `BindCommand` | `BindCommand(keycode, command) -> ?` | Binds a command to a key. |
| `BindJoystickCommand` | *Not specified* | Not documented |
| `CaptureMouse` | *Not specified* | Not documented |
| `ChangeTouchRegionSize` | *Not specified* | Not documented |
| `ChangeTrackpadRegionSize` | *Not specified* | Not documented |
| `CreateTouchRegion` | `CreateTouchRegion(?, ?, string command , boolean, boolean, boolean, boolean, boolean, boolean, number x , number y , number x2 , number y2 ) -> number regionid` | Creates a rectangular region on a touch enabled device that will respond to touch presses. |
| `CreateTouchpadRegion` | *Not specified* | Not documented |
| `DestroyTouchRegion` | `DestroyTouchRegion(number regionid ) -> nil` | Destroys a touch region. |
| `DestroyTouchpadRegion` | *Not specified* | Not documented |
| `Draw3DScene` | `Draw3DScene(boolean draw )` | Not documented |
| `EnableTouchMode` | *Not specified* | Not documented |
| `EvictTextures` | *Not specified* | Not documented |
| `GetAccelerometerOptions` | *Not specified* | Not documented |
| `GetAccelerometerSensitivity` | *Not specified* | Not documented |
| `GetAudioDrivers` | *Not specified* | Not documented |
| `GetAudioOptions` | *Not specified* | Not documented |
| `GetBindsForCommand` | *Not specified* | Not documented |
| `GetCommandForKeyboardBind` | `GetCommandForKeyboardBind(number keycode ) -> string command_down , command_up` | Returns the commands bound to the keycode. |
| `GetCurrentAudioDriverName` | *Not specified* | Not documented |
| `GetCurrentVideoDriverName` | *Not specified* | Not documented |
| `GetFXEffect` | *Not specified* | Not documented |
| `GetFXStringList` | *Not specified* | Not documented |
| `GetGameOptions` | *Not specified* | Not documented |
| `GetGraphicsOptions` | *Not specified* | Not documented |
| `GetInputCodeByName` | *Not specified* | Not documented |
| `GetNameForInputCode` | *Not specified* | Not documented |
| `GetVideoDrivers` | *Not specified* | Not documented |
| `GetVideoOptions` | *Not specified* | Not documented |
| `GetXResolution` | `gkinterface.GetXResolution -> int width` | Returns the width of the current game resolution |
| `GetYResolution` | `gkinterface.GetYResolution -> int width` | Returns the height of the current game resolution |
| `GKBeginFrame` | *Not specified* | Not documented |
| `GKClearFrame` | *Not specified* | Not documented |
| `GKEndFrame` | *Not specified* | Not documented |
| `GKFlipFrame` | *Not specified* | Not documented |
| `GKLoadCommands` | *Not specified* | Not documented |
| `GKPoll` | *Not specified* | Not documented |
| `GKProcessCommand` | *Not specified* | Not documented |
| `GKRenderFrame` | *Not specified* | Not documented |
| `GKUpdateFrame` | *Not specified* | Not documented |
| `HideMouse` | *Not specified* | Not documented |
| `IsAltKeyDown` | `gkinterface.IsAltKeyDown() -> bool pressed` | Test if the Alt key is currently pressed. |
| `IsCtrlKeyDown` | `gkinterface.IsCtrlKeyDown() -> bool pressed` | Test if the Ctrl key is currently pressed. |
| `IsShiftKeyDown` | `gkinterface.IsShiftKeyDown() -> bool pressed` | Test if the shift key is currently pressed. |
| `IsTouchModeEnabled` | `gkinterface.IsTouchModeEnabled() -> bool` | Test if the shift key is currently pressed. |
| `LoadDefaults` | *Not specified* | Not documented |
| `QueryAudio` | *Not specified* | Not documented |
| `QueryVideo` | *Not specified* | Not documented |
| `Set3DViewport` | *Not specified* | Not documented |
| `SetAccelerometerOptions` | *Not specified* | Not documented |
| `SetAccelerometerSensitivity` | *Not specified* | Not documented |
| `SetAudioDriver` | *Not specified* | Not documented |
| `SetAudioOptions` | *Not specified* | Not documented |
| `SetCamera` | *Not specified* | Not documented |
| `SetFOV` | `gkinterface.SetFOV(int angle) -> nil` | Sets the Field of View angle in degrees (from 1 to 179). Note that this value is reset each time the player warps to another sector. It's not saved when... |
| `SetGameOptions` | *Not specified* | Not documented |
| `SetGraphicsOptions` | *Not specified* | Not documented |
| `SetVideoDriver` | *Not specified* | Not documented |
| `SetVideoOptions` | *Not specified* | Not documented |
| `SetVisualQuality` | *Not specified* | Not documented |
| `ShowMouse` | *Not specified* | Not documented |
| `UnbindCommand` | *Not specified* | Not documented |

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/Gkinterface)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
