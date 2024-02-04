# Setup

UltraViolet is a powerful UI library for Roblox based on the principles of Facebooks' React and Redux. Before you start, it is recommended that you have a basic understanding of atleast basic Lua.

## Prerequisites

Make sure you have Lua or Luau scripting knowledge before attempting to use UltraViolet. If you're new to Lua, consider learning the basics before diving into the library, there are many tutorials online that can help you.

::: tip
*Remember*, these are **tips**, **not rules**.
:::

## Installation

Follow these steps to install UltraViolet:

1. **Download the Module:**
   - Visit the [UltraViolet GitHub repository](https://github.com/ShadowsIndeedWhisper/UltraViolet-UI/releases/) releases page.
   - Download and extract the latest version of UltraViolet.

2. **Integrate with Your Project:**
   - Import UltraViolet into ROBLOX by either dragging it, or `ContextMenu -> Insert Object from file`
   - Place it somewhere, such as `ReplicatedStorage/Packages/UltraViolet`


## Usage

Let's start by making a basic app. Start by creating a `LocalScript` in `StarterPlayerScripts` through Rojo or Studio, with the following code:

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local newApp = UltraViolet.CreateElement("ScreenGui", {
	Children = {
		UltraViolet.CreateElement("TextLabel", {
			Properties = {
				Size = UDim2.new(0, 200, 0, 50),
				AnchorPoint = Vector2.new(.5, .5),
				Position = UDim2.fromScale(.5,.5),
				Text = "Hello World!"
			}
		})
	}
})

newApp:Construct(Players.LocalPlayer.PlayerGui)
```

::: warning
Whilst UltraVoilet can be used on the server, it is designed for the client. No testing has been done for the server, so If it is required, use it at your own risk and expect errors.
:::
