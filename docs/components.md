---
sidebar: auto
---

# Components

Components in UltraViolet provide a modular and reusable way to structure your user interfaces. They encapsulate specific elements, allowing you to create complex UIs by composing smaller, self-contained pieces. This guide will delve into the concept of components and demonstrate how to effectively use them in your projects.

## Understanding Components

A component in UltraViolet is essentially an encapsulated unit that combines structure, behavior, and styling. It allows you to break down your UI into manageable pieces, promoting reusability and maintainability. Components can range from simple elements like buttons or input fields to more complex structures like navigation bars or entire forms.

## Component Creation

Components can be created using the `:Create()` method, like so:

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

--// Creates a component with
--/ the name: 'Hello'

local Hello = UltraViolet.Components:Create("Hello")
```

Components should return chunks of elements, or the element itself, through a `:render()` method:

```lua:line-numbers
--// Creates a component with
--/ the name: 'Hello'

local Hello = UltraViolet.Components:Create("Hello")

--// Returns the element within the :render()
--// method. 

function Hello:render()
	return UltraViolet.CreateElement("Frame", {})
end
```

## Rendering Components to the screen

Now we've created the component, and component function, how do we *actually* render it to the screen?
Good question. We can, believe it or not, use the `.CreateElement()` function! Instead of passing the
ROBLOX class, we can pass our 'Hello' Component:

```lua:line-numbers
--// Creates a component with
--/ the name: 'Hello'

local Hello = UltraViolet.Components:Create("Hello")

--// Returns the element within the :render()
--// method. 

function Hello:render()
	return UltraViolet.CreateElement("ScreenGui", {
		Children = {
			UltraViolet.CreateElement("Frame", {
				Properties = {
					Size = UDim2.fromOffset(100,100),
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5, .5)
				}
			})
		}
	})
end

--// Uses the component and constructs it

local newElement = UltraViolet.CreateElement(Hello, {})
newElement:Construct(Players.LocalPlayer.PlayerGui)
```
This will render a blank frame at the center of the screen, as written. But, how can we pass live arguments that change what renders?

## Passing arguments

It's possible to pass arguments through components to change what's being rendered. Within the `:render()` method, `self` is the container for Arguments. So if there was a `text` argument, it would be `self.text`:

```lua:line-numbers
function Hello:render()
	return UltraViolet.CreateElement("ScreenGui", {
		Children = {
			UltraViolet.CreateElement("TextLabel", {
				Properties = {
					Size = UDim2.fromOffset(100,100),
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5, .5),
					Text = `Hello, {self.name}!`,
					TextScaled = true
				}
			})
		}
	})
end
```

We can use the `Argument` table in the configuration to pass this name:

```lua:line-numbers
local newElement = UltraViolet.CreateElement(Hello, {
	Arguments = {
		name = "jeff"
	}
})

newElement:Construct(Players.LocalPlayer.PlayerGui)
```

This would render a textlabel with the text: "**Hello, jeff!**"

::: danger
You **cannot** render components inside of components. This will most likely be added in the future. It is very messy, and therefore has been excluded.
:::

Here's a good, but basic example of how components can be used:

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

--// Creates a component with
--/ the name: 'Hello'

local Hello = UltraViolet.Components:Create("Hello")

--// Returns the element within the :render()
--// method. 

function Hello:render()
	local names = self.names
	
	if #names > 3 then
		error("Only 3 people allowed at my party >:( 😡😡🤬🤬🤬🤬")
	end
	
	local function createName(name: string)
		return UltraViolet.CreateElement("TextLabel", {
			Properties = {
				Size = UDim2.fromOffset(200,50),
				TextScaled = true,
				Text = name or "Nobody Joined :(",
				Font = Enum.Font.Gotham,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = .35,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			},
			
			Children = {
				UltraViolet.CreateElement("UICorner", {
					Properties = {
						CornerRadius = UDim.new(0, 6)
					}
				}),
			}
		})
	end
		
		
	return UltraViolet.CreateElement("ScreenGui", {
		Children = {
			UltraViolet.CreateElement("Frame", {
				
				Properties = {
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5 ,.5),
					Size = UDim2.fromScale(.2, .8),
					BackgroundTransparency = .35,
					BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				},
				
				Children = {
					UltraViolet.CreateElement("UIListLayout", {
						Properties = {
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							Padding = UDim.new(0, 10)
						}	
					}),
					
					UltraViolet.CreateElement("UICorner", {
						Properties = {
							CornerRadius = UDim.new(0, 5)
						}
					}),
					
					createName(names[1]),
					createName(names[2]),
					createName(names[3]),
					
				}
			})
		}
	})
end

--// Uses the component and constructs it

local newElement = UltraViolet.CreateElement(Hello, {
	Arguments = {
		names = {
			"jeff",
			"bob",
			"dave"
		}
	}
})

newElement:Construct(Players.LocalPlayer.PlayerGui)
```

## Clock, Part 2

Let's recreate that clock program from earlier, this time with components and milliseconds:

```lua:line-numbers{6,8-13,15-22,24-34,36-47,53-57,59,64-80}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local Clock = UltraViolet.Components:Create("Clock")

function Clock:render()
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			IgnoreGuiInset = true,
			Name = "ClockGui"
		},
		
		Children = {
			UltraViolet.CreateElement("Frame", {
				Properties = {
					Name = "Container",
					Size = UDim2.fromScale(1,1),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				}
			}),
			
			UltraViolet.CreateElement("TextLabel", {
				Properties = {
					Name = "ClockTime",
					Size = UDim2.fromScale(1,1),
					BackgroundTransparency = 1,
					TextScaled = true,
					Font = Enum.Font.Gotham,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Text = tostring(self.clockTime)
				}
			}),
			
			UltraViolet.CreateElement("TextLabel", {
				Properties = {
					Name = "ClockTimeMilliseconds",
					Size = UDim2.fromScale(0.146, 0.065),
					Position = UDim2.fromScale(0.427, 0.552),
					BackgroundTransparency = 1,
					TextScaled = true,
					Font = Enum.Font.Gotham,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Text = tostring(self.clockTimeMilliseconds)
				}
			}),
		}
	})
end

local clockTime = 0
local currentClock = UltraViolet.CreateElement(Clock, {
	Arguments = {
		clockTime = clockTime
	}
}):Construct(Players.LocalPlayer.PlayerGui)

local lastTick = tick()

while true do
	task.wait()

	local currentTick = tick()
	local elapsedTime = currentTick - lastTick

	if elapsedTime >= 0.001 then 
		lastTick = currentTick
		currentClock:Destroy()

		clockTime = clockTime + elapsedTime
		local seconds = math.floor(clockTime)
		local milliseconds = math.floor((clockTime - seconds) * 1000)

		currentClock = UltraViolet.CreateElement(Clock, {
			Arguments = {
				clockTime = seconds,
				clockTimeMilliseconds = milliseconds
			}
		}):Construct(Players.LocalPlayer.PlayerGui)
	end
end

```