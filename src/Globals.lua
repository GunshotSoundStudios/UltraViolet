local classes = script.Parent.Classes

local _G = {
	private = {

	},
	globals = require(classes.GlobalClass)
}


_G.globals.__index = _G.globals


return _G