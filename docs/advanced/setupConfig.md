---
sidebar: auto
---

# Setup Configuration

UltraViolet offers setup configuration that allows you to modify the way certain things are done internally, for example the way UltraViolet handles classes. You can create "*custom classes*" and append them to normal instances, like nicknames. For example, I could call a 'Frame' an interface:

```lua:line-numbers
UltraViolet.Setup({
	tokenExchange = {
		Frame = "Interface"
	}
})

local app = UltraViolet.CreateElement("ScreenGui", {
	Children = {
		UltraViolet.CreateElement("Interface", { --// Points to frame
			Properties = {
				Size = UDim2.fromOffset(100,100)
			}
		})
	}
})

app:Construct(Players.LocalPlayer.PlayerGui) --// Renders a frame
```
