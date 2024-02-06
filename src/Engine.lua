local Mother = script.Parent

local Types = require(Mother.Types)
local ElementClass = require(Mother.Classes.ElementClass)

local Engine = {
	Animation = require(Mother.Classes.AnimationClass),
	Components = require(Mother.Classes.ComponentClass),
}

local Settings = {} :: Types.UVSettings

function Engine.Setup(settings: Types.UVSettings?)
	
	local t = {
		Data = {
			Configuration = settings
		}
	}
	
	Settings = settings
	
	return setmetatable(t, Engine)
end

function Engine.CreateElement(className: string, objectConfig: Types.Element)
	
	if type(className) == "string" then
		for val, pair in pairs(Settings.tokenExchange or {}) do
			if className == pair then
				className = val
			end
		end
	end
	
	local t = {
		Object = {
			className = className,
			object = objectConfig,
			
		},

		Properties = objectConfig.Properties,
		Children = objectConfig.Children,
		Events = objectConfig.Events,
		Animations = objectConfig.Animations,
		Arguments = objectConfig.Arguments,
		onConstruction = function() end,
		States = {},
		type = "Element"
	}

	return setmetatable(t, ElementClass) 
end


return Engine