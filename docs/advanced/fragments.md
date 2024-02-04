::: warning
Fragments have been deprecated and are no longer maintained in the latest version of UltraViolet. It is reccomended you use container frames instead.
:::

# Fragments

Fragments play a pivotal role in simplifying the creation of modular and reusable components. A fragment represents a specific chunk of elements that can be displayed on the screen at once.

## How do you use fragments?

Fragments can be used with the `CreateFragmentation()` function. It needs an array, and elements can be created inside that array.

### Without Fragments:

```lua:line-numbers
local screenUI = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

local app = UltraViolet.CreateElement("Frame", { --// Points to frame
	Properties = {
		Size = UDim2.fromOffset(100,100),
		Name = "Container"
	},
	
	Children = {
		--// We can't make 2 Frames at once, and therefore a container must be made
		UltraViolet.CreateElement("Frame", {
			Properties = {
				Size = UDim2.fromOffset(100,100)
			}
		}),
		
		UltraViolet.CreateElement("Frame", {
			Properties = {
				Size = UDim2.fromOffset(100,100)
			}
		}),
	}
})


app:Construct(screenUI)
```

Hierarchy in-game:

```json
ScreenGui: [
    Container: [
        Frame
        Frame
    ]
]
```

### With Fragments:

```lua:line-numbers
local screenUI = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

local app = UltraViolet.CreateFragmentation({
	UltraViolet.CreateElement("Frame", {
		Properties = {
			Size = UDim2.fromOffset(100,100)
		}
	}),

	UltraViolet.CreateElement("Frame", {
		Properties = {
			Size = UDim2.fromOffset(100,100)
		}
	}),
})

app:ConstructFragment(screenUI) --// ConstructFragment constructs and renders the fragment
```

Hierarchy in-game:

```json
ScreenGui: [
    Frame
    Frame
]
```