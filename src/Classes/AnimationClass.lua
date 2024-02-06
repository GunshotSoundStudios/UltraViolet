local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local mother = script.Parent.Parent

local types = require(mother.Types)

local Animation = {
	Transition = {},
}

local private = {
	anim = {}
}

private.anim.__index = private.anim

function Animation.Transition.new(data: types.Transition?)
	local t: types.Transition
	
	if data then
		t = data
		t["Type"] = "Transition"
	else
		t = {
			duration = 1,
			delay = 0,
			reverses = false,
			repeatCount = 0,
			easingStyle = Enum.EasingStyle.Linear,
			easingDirection = Enum.EasingDirection.In
		}
	end
	
	return t
end

function Animation.new(data: {[string]: any}, transition: types.Transition)
	local t = {
		propertyChange = data,
		transition = transition,
		objects = {},
		Type = "Animation",
		callback = nil
	}
	
	return setmetatable(t, private.anim)
end

function private.anim:Edit(replaceEntireOfPrevious: boolean, canUpdateValues: boolean ,callbackArgs: {data: {[string]: any}?, transition: types.Transition?})
	if replaceEntireOfPrevious then
		self.propertyChange = callbackArgs.data or self.propertyChange
		self.transition = callbackArgs.transition or self.transition
	else
		if callbackArgs.data then
			for propName, propValue in pairs(callbackArgs.data) do
				if self.propertyChange[propName] then
					if canUpdateValues then
						self.propertyChange[propName] = propValue
					else
						continue
					end
				else
					self.propertyChange[propName] = propValue
				end
			end
		end
		
		if callbackArgs.transition then
			if canUpdateValues then
				self.transition = callbackArgs.transition
			end
		end
	end
end

function private.anim:Play()
	
	local newInfo = self.transition

	newInfo.duration = newInfo.duration or 1
	newInfo.delay = newInfo.delay or 0
	newInfo.reverses = newInfo.reverses or false
	newInfo.repeatCount = newInfo.repeatCount or 0
	newInfo.easingStyle = newInfo.easingStyle or Enum.EasingStyle.Linear
	newInfo.easingDirection = newInfo.easingDirection or Enum.EasingDirection.In

	newInfo = TweenInfo.new(newInfo.duration, newInfo.easingStyle, newInfo.easingDirection, newInfo.repeatCount, newInfo.reverses, newInfo.delay)
	
	local finished = false
	
	local propcLen = 0
	
	for _pn, _pv in pairs(self.propertyChange) do
		propcLen+=1
	end
	
	for _, OBJECT in ipairs(self.objects) do
		local idx = 0
		for propName, propValue in pairs(self.propertyChange) do
			idx+=1
			if typeof(propValue) ~= "table" then
				coroutine.wrap(function()
					local a = TweenService:Create(
						OBJECT,
						newInfo,
						{
							[propName] = propValue
						}
					)
					
					a:Play()

					if idx == propcLen then
						a.Completed:Wait()
						finished = true
					end
				end)()
			else
				for _,  NEWVALUE in ipairs(propValue) do
					local a = TweenService:Create(
						OBJECT,
						newInfo,
						{
							[propName] = NEWVALUE
						}
					)
					
					a:Play()
					a.Completed:Wait()
				end
				finished = true
			end
			
		end
	end
	
	if self.callback then
		repeat
			task.wait()
		until finished == true
		
		self.callback(self.propertyChange)
	end
	
end

function private.anim:AndThen(callbackFunction: (PropertiesChanged: {[string]: any}) -> ())
	local pC = self.propertyChange
	self.callback = callbackFunction
	
	return
end


return Animation