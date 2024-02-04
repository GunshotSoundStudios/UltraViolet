---
sidebar: auto
---

# Events

Events play a crucial role in creating interactive and responsive user interfaces. In UltraViolet, events allow you to handle user interactions, such as clicks or mouse hover, and respond to them with specific actions. This guide will cover the basics of using events.

## Introduction

In UltraViolet, events are defined within the `Events` table of an element's configuration. Each event corresponds to a specific user interaction or system-triggered action. We can start by creating a button:

```lua:line-numbers
local newButton = UltraViolet.CreateElement("TextButton", {
	Properties = {
		AnchorPoint = Vector2.new(.5,.5),
		Position = UDim2.fromScale(.5,.5),
		Size = UDim2.fromOffset(500,500),
		TextScaled = true,
		Text = "Click me!",
		Parent = newScreen
	}
})
```

Now, we can add the *events* table to make something happen when we click the button like so:

```lua:line-numbers
Events = {
		--// This callback function
		--// will be ran when this 
		--// event is fired, with the
		--// given parameters.
		
		MouseButton1Click = function(rbxConnection, object: TextButton)
			
			--// The parameters are given, along with the 
			--// actual object itself. We can now modify
			--// properties of the object!
			
			object.Text = "Thanks for clicking me!"
		end,
	}
```
Complete Code:

::: details
```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

--// Function to create our ScreenGui
--// We could construct the screen 
--// inside the function, but we'll leave
--// it out for now.

local function createScreen()
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			IgnoreGuiInset = true
		}
	})
end

local newScreen = createScreen():Construct(Players.LocalPlayer.PlayerGui)

--// Create our button

local newButton = UltraViolet.CreateElement("TextButton", {
	Properties = {
		AnchorPoint = Vector2.new(.5,.5),
		Position = UDim2.fromScale(.5,.5),
		Size = UDim2.fromOffset(500,500),
		TextScaled = true,
		Text = "Click me!",
		Parent = newScreen
	},
	
	Events = {
		--// This callback function
		--// will be ran when this 
		--// event is fired, with the
		--// given parameters.
		
		MouseButton1Click = function(rbxConnection, object: TextButton)
			
			--// The parameters are given, along with the 
			--// actual object itself. We can now modify
			--// properties of the object!
			
			object.Text = "Thanks for clicking me!"
		end,
	}
})

--// We don't need to pass a constructor
--// since we've already declared the parent
--// within the properties.

newButton:Construct()
```
:::

To listen to `GetPropertyChangedSignal`, you can create a `CHANGE` table with the properties you want to listen to within. It will return the property changed, and the object itself:

```lua:line-numbers
Events = {
		Change = {
			Text = function(newText, Object: TextBox)
				print(newText)
			end,
		}
	}
```