local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local mother = script.Parent.Parent

local types = require(mother.Types)

local ComponentClass = {}

local private = {
	statefullComponents = {
		
	}
}

private.statefullComponents.__index = private.statefullComponents

function ComponentClass:Create(componentName: string)
	local t = {
		data = {
			compName = componentName
		},
		states = {},
		type = "StatefullComponent"
	}
	
	return setmetatable(t, private.statefullComponents)
end

function private.statefullComponents:SetState(data: {[string]: any} | (state: any) -> ({[string]: any}))
	if typeof(data) == "table" then
		for stateName, stateValue in pairs(data) do
			self.states[stateName] = stateValue
		end
	elseif typeof(data) == "function" then
		local newValues = data(self.states)	
		self.states = newValues
	end
	
	
	return self.states
end

function private.statefullComponents:GetStates()
	return self.states
end

function private.statefullComponents:GetStateFromName(stateName: string): any | nil
	return self.states[stateName]
end

function private.statefullComponents:GetStatesFromValue(stateValue: any): {any} | nil
	local t = {}
	
	for stateName, stateValue_ in pairs(self.States) do
		if stateValue_ == stateValue then
			table.insert(t, stateValue_)
		end
	end
	
	return t
end

function private.statefullComponents:RemoveState(stateName: string)
	if self.states[stateName] then
		local _i = 0
		local cI = 0
		
		for _sN, _sV in pairs(self.states) do
			_i += 1
			if _sN == stateName then
				cI = _i
			end
		end
		
		table.remove(self.states, cI)
	end
end

return ComponentClass