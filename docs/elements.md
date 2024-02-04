---
outline: deep
---

# Elements

UltraViolet introduces the concept of "**Elements**" as the fundamental building blocks for creating user interfaces in Roblox. Similar to React, these elements represent UI components that can be composed and arranged to design sophisticated interfaces. Understanding how to work with UltraViolet elements is essential for building powerful and dynamic UIs.

## What *are* elements?

In UltraViolet, an "*Element*" is the simplest and most basic representation of a UI component. It encapsulates the structure, properties, and behavior of a specific part of the user interface. 

You can create an element with the `.CreateElement()` function, with the first argument being a ROBLOX Class (like in `instance.new`), and the second being a configuration parameter. Properties, Children, Events, Animations, and Arguments can be passed through the configuration table, labled by the key:

```lua:line-numbers
local newElement = UltraViolet.CreateElement("Frame", {
	Properties = {
		Size = UDim2.fromOffset(50, 50)
	}
})
```
This, by itself doesn't do anything. Elements are miniture re-usable chunks of data. To actually render this to the screen, we can use the `:Construct()` method, with an optional constructor:

```lua:line-numbers
--// Constructs 'newElement' in Workspace/Example
newElement:Construct(workspace.Example)
```

Here's another example using Children. You can pass another Element as a child and UltraVoilet will handle the compilation and parenting:

```lua:line-numbers
local newElement = UltraViolet.CreateElement("Frame", {
	Properties = {
		Size = UDim2.fromOffset(50, 50)
	},
	
	Children = {
		UltraViolet.CreateElement("TextLabel", {
			Properties = {
				Size = UDim2.fromScale(1,1),
				TextScaled = true,
				Text = "Hello World!"
			}
		})
	}
})

--// Constructs 'newElement' in Players/LocalPlayer/PlayerGui
--// We won't actually see this due to the fact that it isn't
--// Parented to a ScreenGui!

newElement:Construct(Players.LocalPlayer.PlayerGui)
```

## A simple program

Let's create a simple program that displays how long the game has been running for using our current knowledge:

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

--// We can use a function that returns the create
--// element function to make our code more organised.
--// This will be used for Components and States, so it's
--// reccomended you familiarize yourself with this method.

local function DisplayClock(Time: number)
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			Name = "ClockUI",
			IgnoreGuiInset = true,
		},
		
		Children = {
			UltraViolet.CreateElement("TextLabel", {
				Properties = {
					Size = UDim2.fromScale(1,1),
					TextScaled = true,
					Text = tostring(Time),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Font = Enum.Font.Gotham,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				}
			})
		}
	})
end

local currentTime = 0
local app = DisplayClock(currentTime):Construct(Players.LocalPlayer.PlayerGui)

while task.wait(1) do
	currentTime += 1
	
	app:Destroy()
	app = DisplayClock(currentTime):Construct(Players.LocalPlayer.PlayerGui)
end
```

Now, we're going to be talking about element **Events** and **Animations** in the following
pages.