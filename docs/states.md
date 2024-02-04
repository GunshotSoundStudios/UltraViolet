---
sidebar: auto
---

# States

States in UltraViolet play a crucial role in managing dynamic content and user interactions within your user interface. Understanding how to effectively use states allows you to create responsive and interactive applications. This guide will explore the concept of states in UltraViolet, their use cases, and how to implement them in your projects.

## Introduction

States represent the various conditions or modes that your UI can exist in. They are dynamic data that influence the appearance and behavior of your components. In UltraViolet, states are often used to manage changes in application logic, or dynamic content.

## How do you create a state?

States are linked to components, so to create a state you start by creating a component:

```lua:line-numbers
local stateTest = UltraViolet.Components:Create("StateTest")

stateTest:SetState({})
```

We can pass the state name, and state value to create a state; the key being the name and the value being the.. value:
```lua:line-numbers
local stateTest = UltraViolet.Components:Create("StateTest")

stateTest:SetState({
	myValue = "Hello World!"
})
```
The `myValue` state is now appended to the `StateTest` component, with the value: "**Hello World!**"!
We can retrieve this value using either `GetStateFromName` or `GetStates`:

```lua:line-numbers
local stateTest = UltraViolet.Components:Create("StateTest")

stateTest:SetState({
	myValue = "Hello World!"
})

local myValueState = stateTest:GetStateFromName("myValue")
local myValueStateMethod2 = stateTest:GetStates()

print(myValueState, myValueStateMethod2) 

--// OUTPUT:

--// Hello World! { myValue = "Hello World!" }
```

It's also possible to retrive these states within the `render` method of our component:

```lua:line-numbers
UltraViolet.CreateElement("TextLabel", {
				Properties = {
					Size = UDim2.fromOffset(200,50),
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5, .5),
					TextScaled = true,
					Text = stateTest:GetStateFromName("myValue")
				}
			})
```

States can be simply used to either return 1 thing or another, like, let's say for example, whether a UI should be dark or light theme:
(Code truncated for viewing experience 😉)

::: details

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local themeRenderer = UltraViolet.Components:Create("themeRenderer")

--// Creates our State
themeRenderer:SetState({
	theme = "Light"
})

local themes = {
	Light = {
		ForeGround = Color3.fromRGB(255, 255, 255)
	},

	Dark = {
		ForeGround = Color3.fromRGB(13, 13, 13)
	}
}

function themeRenderer:render()
	local currentTheme = themeRenderer:GetStateFromName("theme")
	local newTheme = (currentTheme == "Light") and "Dark" or "Light"

	return UltraViolet.CreateElement("ScreenGui", {
		Children = {
			UltraViolet.CreateElement("Frame", {
				Properties = {
					Size = UDim2.fromOffset(100,100),
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5, .5),
					BackgroundColor3 = themes[newTheme].ForeGround
				}
			}),

			UltraViolet.CreateElement("TextButton", {
				Properties = {
					Size = UDim2.fromOffset(200,50),
					Text = "Change Theme"
				},

				Events = {
					MouseButton1Click = function(rbx, obj)
						-- Toggle theme
						
						local currentTheme = themeRenderer:GetStateFromName("theme")
						local newTheme = (currentTheme == "Light") and "Dark" or "Light"
						themeRenderer:SetState({
							theme = newTheme
						})
						

						local newTheme = TweenService:Create(
							obj.Parent.Frame,
							TweenInfo.new(.5, Enum.EasingStyle.Quad),
							{
								BackgroundColor3 = themes[currentTheme].ForeGround
							}
						)

						newTheme:Play()
						
						local tmp = UltraViolet.CreateElement(themeRenderer, {}) :: ScreenGui
						tmp = tmp:Construct(Players.LocalPlayer.PlayerGui)
						tmp.DisplayOrder = -1
						
						newTheme.Completed:Wait()
						
						pcall(function()
							obj.Parent:Destroy()
						end)

						
						
						
						local newElement = UltraViolet.CreateElement(themeRenderer, {})
						newElement:Construct(Players.LocalPlayer.PlayerGui)
						task.wait(.4)
						tmp:Destroy()
						
					
					end,
				}
			})
		},
	})
end

--// Call the function
pcall(function()
	local newElement = UltraViolet.CreateElement(themeRenderer, {})
	newElement:Construct(Players.LocalPlayer.PlayerGui)
end)
```
:::

## Clock Program, Part 3

States are one of the most useful features, yet also one of the most simplest. We can store our clock-time and milliseconds inside
a state in the following remake of the previous Clock Program:

```lua:line-numbers{10-12,27,45-47}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local Clock = UltraViolet.Components:Create("Clock")


--// Create our State
Clock:SetState({
	Time = 0,
})


function Clock:render()
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			Name = "ClockUI",
			IgnoreGuiInset = true,
		},

		Children = {
			UltraViolet.CreateElement("TextLabel", {
				Properties = {
					Size = UDim2.fromScale(1, 1),
					TextScaled = true,
					Text = tostring(Clock:GetStateFromName("Time")), --// Get the data from the state
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Font = Enum.Font.Gotham,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				}
			})
		}
	})
end

local currentTime = 0
local app = UltraViolet.CreateElement(Clock, {}):Construct(Players.LocalPlayer.PlayerGui)

while true do
	task.wait(1) 

	currentTime += 1

	Clock:SetState({
		Time = currentTime,
	})
	
	--// Deconstruct and reconstruct the state
	
	app:Destroy()
	app = UltraViolet.CreateElement(Clock, {}):Construct(Players.LocalPlayer.PlayerGui)
end


```