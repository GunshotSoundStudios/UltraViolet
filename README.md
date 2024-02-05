<h1 align="center">UltraViolet</h1>
<div align="center">
	<a href="https://gunshotsoundstudios.github.io/UltraViolet/"><img src="https://img.shields.io/badge/docs-website-green.svg" alt="Documentation" /></a>
</div>

<div align="center">
	A UI & State management library for ROBLOX, based of ROACT and REACT
</div>

<div>&nbsp;</div>

## Basic Usage

For more detailed examples, please refer to the [documentation](https://gunshotsoundstudios.github.io/UltraViolet/)!
Below is a basic script. Usually you would break these scripts down into smaller modules that each contain Components.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local myComponent = UltraViolet.Components:Create("Button")

myComponent:SetState({
	buttonPress = 0
})

local function initScreen()
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			Name = "Container",
			IgnoreGuiInset = true
		}
	})
end

function myComponent:render()
	
	local newScreen = initScreen():Construct(Players.LocalPlayer.PlayerGui)
	
	return UltraViolet.CreateElement("TextButton", {
		Properties = {
			Parent = newScreen,
			AnchorPoint = Vector2.new(.5, .5),
			Position = UDim2.fromScale(.5, .5),
			Size = UDim2.fromOffset(200,50),
			Text = `Clicked {tostring(myComponent:GetStateFromName("buttonPress"))} times!`
		},
		
		Events = {
			MouseButton1Click = function(rbx, obj)
				obj:Destroy()
				UltraViolet.CreateElement(myComponent, {}):Construct()
				myComponent:SetState(function(state)
					return {
						buttonPress = state.buttonPress + 1
					}
				end)
			end,
		}
	})
end

UltraViolet.CreateElement(myComponent, {}):Construct()
```

## License
UltraViolet is available under the Apache 2.0 license. See [LICENSE.txt](LICENSE.txt) for details."# UltraViolet" 
