# Simple Garry's Mod Server Status Checker

This Garry's Mod addon checks the server status using Steam API and displays a custom VGUI panel when the server is down.

# Installation

- Clone or download this repository.
- Place the aCrashScreen lua folder into your Garry's Mod addons directory.

# Usage

- This addon automatically checks the server status and displays a custom screen if the server is down.

# Files

- lua/autorun/cl_logic.lua: Contains the logic for checking server status and displaying the VGUI panel.
- lua/autorun/cl_vgui.lua: Defines the VGUI panel to be displayed when the server is down.

# Configuration

- You can configure the VGUI panel's header, sub-header, and image in lua/autorun/cl_vgui.lua:

```lua
--[[ CONFIG ]]
aCrashScreen = aCrashScreen or {}
aCrashScreen.Header = "Server is currently down. Please wait..."
aCrashScreen.SubHeader = "We are working on it!"
aCrashScreen.ImgurID = "Wjdrmch"
--[[ END CONFIG ]]
```

# Example

- The addon will fetch the server status using the Steam API every 0.66 seconds. If the server is detected as down, it will display a screen with the specified header, sub-header, \* and an image from Imgur.

# License

This project is licensed under the MIT License. See the [LICENSE](license.md) file for details.
