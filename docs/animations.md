---
sidebar: auto
---

# Animations

Animations add a dynamic and visually appealing aspect to user interfaces. In UltraViolet, animations can be applied to elements, providing transitions and effects. This guide will cover the basics of using animations.

## Introduction

Animations, like Events are defined within the `Animations` table of an element's configuration. An animation can be a simple transition or a complex sequence of movements, providing flexibility in creating UIs.

In the following example, we're going to pair an event to MouseEnter and MouseLeave to change the size, and color of the frame:

```lua:line-numbers
Animations = {
		MouseEnter = {
			Size = UDim2.fromOffset(550,550),
			BackgroundColor3 = Color3.fromRGB(255, 103, 106)
		},
		
		MouseLeave = {
			Size = UDim2.fromOffset(500,500),
			BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		},
	}
```

## Transitions

Simple, but boring, right?
The animation is *VERY* slow, but we can speed it up using transitions.
A transition holds a `TweenInfo` value, and it can be created like this:

```lua:line-numbers
local myTransition = UltraViolet.Animation.Transition.new()
myTransition.duration = .5
```

We can either pass the data through the parameter, or set it manually later like shown in the example above. 
Now, it is possible to apply this transition using the `transition` key: 

```lua:line-numbers
Animations = {
		MouseEnter = {
			Size = UDim2.fromOffset(550,550),
			BackgroundColor3 = Color3.fromRGB(255, 103, 106)
		},
		
		MouseLeave = {
			Size = UDim2.fromOffset(500,500),
			BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		},
		
		transition = myTransition
	}
```

Wowie, that's better!
We can change much more than the duration, here's a list of properties that we can modify:

| Property Name        |      Description      |  Default Value |
| ------------- | :-----------: | ----: |
| Duration      | The length of the transition | 1 |
| Delay      |   The delay between tweens    |   0 |
| Reverses |   Should the tween go back to it's original value    |    false |
| RepeatCount |   How many times it should repeat    |    0 |
| EasingStle |   The EasingStyle    |    `Enum.EasingStyle.Linear` |
| EasingDirection |   The EasingDirection    |    `Enum.EasingDirection.In` |

Alright, now let's make a more complex button with animations and events. The button will change color, text, and size when clicked / hovered:

```lua:line-numbers

local newButton = UltraViolet.CreateElement("TextButton", {
	Properties = {
		AnchorPoint = Vector2.new(.5,.5),
		Position = UDim2.fromScale(.5,.5),
		Size = UDim2.fromOffset(200,50),
		TextScaled = true,
		Text = "Click Me!",
		Parent = newScreen
	},
	
	Events = {
		MouseButton1Down = function(rbxConnection, Object: TextButton)
			Object.Text = "Your holding down on me!"
		end,
		
		MouseButton1Up = function(rbxConnection, Object: TextButton)
			Object.Text = "Click Me!"
		end,
	},
	
	Animations = {
		MouseEnter = {
			Size = UDim2.fromOffset(220, 70),
			BackgroundColor3 = Color3.fromRGB(255, 103, 106)
		},
		
		MouseLeave = {
			Size = UDim2.fromOffset(200,50),
			BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		},
		
		MouseButton1Down = {
			Size = UDim2.fromOffset(230, 80),
			BackgroundColor3 = Color3.fromRGB(255, 37, 37)
		},
		
		MouseButton1Up = {
			Size = UDim2.fromOffset(220, 70),
			BackgroundColor3 = Color3.fromRGB(255, 103, 106)
		},
		
		transition = myTransition
	}
})
```

## Animations

This is a very basic hover animation. But, what if I wanted a pre - set out animation to occur, let's say when I press a button a frame moves? Well, we can use `Animations`. `Animations` can also be updated *during* runtime! You can create an animation with the `Animation.new` function:

```lua:line-numbers
local myTransition = UltraViolet.Animation.Transition.new()
myTransition.duration = .2

local myAnimation = UltraViolet.Animation.new({}, myTransition)
```

We can pass the property of the animation through the array. We can then play the animation from anywhere using the `Play()` method. Once an animation finishes, you can also use the `AndThen()` method to run a function. This fires after a chained animation, or just a normal one:

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local myTransition = UltraViolet.Animation.Transition.new()
myTransition.duration = .5
myTransition.easingStyle = Enum.EasingStyle.Bounce

local myAnimation = UltraViolet.Animation.new({
	Position = UDim2.fromScale(0.2 ,0.2)    
}, myTransition)

local function createScreen()
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			IgnoreGuiInset = true
		}
	})
end

local newScreen = createScreen():Construct(Players.LocalPlayer.PlayerGui)

--// Create our button

local newFrame = UltraViolet.CreateElement("Frame", {
	Properties = {
		Size = UDim2.fromOffset(50, 50),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.2),
		Parent = newScreen
	},
	
	Animations = {
		animations = {myAnimation}
	}
})

local newButton = UltraViolet.CreateElement("TextButton", {
	Properties = {
		AnchorPoint = Vector2.new(.5,.5),
		Position = UDim2.fromScale(.5,.5),
		Size = UDim2.fromOffset(200,50),
		TextScaled = true,
		Text = "Click Me!",
		Parent = newScreen
	},
	
	Events = {
		MouseButton1Down = function(rbxConnection, Object: TextButton)
			myAnimation:Play()
		end,
	},
	
})


newFrame:Construct()
newButton:Construct()
```

::: warning
Using `:Play()` on an animation runs the animation on ALL binded Guis!
:::

## Chaining Animations

Now that we've figured how to do a *singular* animation, how do we chain them together? It's quite simple! It's as easy as passing an array with a table of the properties you want to change, like this:

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local myTransition = UltraViolet.Animation.Transition.new()
myTransition.duration = 1
myTransition.easingStyle = Enum.EasingStyle.Quad

local myAnimation = UltraViolet.Animation.new({
	Position = {UDim2.fromScale(0.2 ,0.2), UDim2.fromScale(0.2, 0.8), UDim2.fromScale(0.8, 0.8), UDim2.fromScale(0.8, 0.2), UDim2.fromScale(0.5, 0.2)}
}, myTransition)

local function createScreen()
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			IgnoreGuiInset = true
		}
	})
end

local newScreen = createScreen():Construct(Players.LocalPlayer.PlayerGui)

--// Create our button

local newFrame = UltraViolet.CreateElement("Frame", {
	Properties = {
		Size = UDim2.fromOffset(50, 50),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.2),
		Parent = newScreen
	},
	
	Animations = {
		animations = {myAnimation}
	}
})

local newButton = UltraViolet.CreateElement("TextButton", {
	Properties = {
		AnchorPoint = Vector2.new(.5,.5),
		Position = UDim2.fromScale(.5,.5),
		Size = UDim2.fromOffset(200,50),
		TextScaled = true,
		Text = "Click Me!",
		Parent = newScreen
	},
	
	Events = {
		MouseButton1Down = function(rbxConnection, Object: TextButton)
			myAnimation:Play()
		end,
	},
	
})


newFrame:Construct()
newButton:Construct()
```

You can add as many keypoints as you want with as many animations as you want. Keep in mind, the transition time is time it takes to move to each **keypoint**, not the animation itself. So if the duration was *.5*, and there were 2 keypoints, the animation would take exactly *1 second* to finish.

As mentioned earlier, the `AndThen()` function is used to append a function to the end of an animation:

```lua:line-numbers
myAnimation:AndThen(function()
	print("Mom, Dad, I'm famous!")
    print("I told you scripting on roblox would pay off! 🙄")
end)
```

There's one more function that allows us to change the animation data *during runtime*. This means we could make the frame, for example, go to a random position on the screen once a button is clicked. This is possible with the `Edit()` method:

```lua:line-numbers
myAnimation:Edit(false, true, {
	data = {
		Position = --// This would ONLY change the Position value, saving our other values
	},
	
	transition = myTransition
})
```

Here's the **full** code to the example I mentioned earlier, of the `Frame` moving to random positions on the screen on a button press. It utilises the `Edit()` method as just shown!

```lua:line-numbers
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltraViolet = require(ReplicatedStorage.Packages.UltraViolet)

local myTransition = UltraViolet.Animation.Transition.new()
myTransition.duration = 1
myTransition.easingStyle = Enum.EasingStyle.Quad

local myAnimation = UltraViolet.Animation.new({}, myTransition)

myAnimation:AndThen(function()
	print("Mom, Dad, I'm famous!")
end)

local function createScreen()
	return UltraViolet.CreateElement("ScreenGui", {
		Properties = {
			IgnoreGuiInset = true
		}
	})
end

local newScreen = createScreen():Construct(Players.LocalPlayer.PlayerGui)

local newFrame = UltraViolet.CreateElement("Frame", {
	Properties = {
		Size = UDim2.fromOffset(75, 75),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.2),
		Parent = newScreen
	},
	
	Animations = {
		animations = {myAnimation}
	}
})

local newButton = UltraViolet.CreateElement("TextButton", {
	Properties = {
		AnchorPoint = Vector2.new(.5,.5),
		Position = UDim2.fromScale(.5,.5),
		Size = UDim2.fromOffset(200,50),
		TextScaled = true,
		Text = "Click Me!",
		Parent = newScreen
	},
	
	Events = {
		MouseButton1Down = function(rbxConnection, Object: TextButton)
			local newRndObj = Random.new()
			
			local X = newRndObj:NextNumber()
			local Y = newRndObj:NextNumber()
			
			myAnimation:Edit(false, true, {
				data = {
					Position = UDim2.fromScale(X, Y)
				},

				transition = myTransition
			})
			
			myAnimation:Play()
		end,
	},
	
})


newFrame:Construct()
newButton:Construct()
```

In the next section, we'll talk about *Components*, chunks of elements that can be re - used from functions.