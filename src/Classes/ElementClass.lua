local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local types = require(script.Parent.Parent.Types)
local animClass = require(script.Parent.AnimationClass)

local Element = {}
Element.__index = Element

function Element:Construct(Constructor)
	
	
	
	local this = self :: types.elementInternal
	
	local s, newObject: any = pcall(Instance.new, this.Object.className)
	if not s then
		
		if this.Object.className["type"] == "StatefullComponent" then
			
			if this.Object.className["render"] then
				
				if this.Object.className["render"](this.Arguments)["type"] == "Element" then
					local newElement = setmetatable(this.Object.className["render"](this.Arguments), Element)
					newObject = newElement:Construct()
				else
					local newElement = setmetatable(this.Object.className["render"](this.Arguments), Element)
					newObject = newElement:ConstructFragment()
				end
			end
		end
	end
	
	
	if this.Properties then
		for propName, propVal in pairs(this.Properties) do
			local s, r = pcall(function()
				newObject[propName] = propVal
			end)
			
			if s then
				newObject[propName] = propVal
			end
		end
	end

	if this.Children then
		for _, childData in ipairs(this.Children) do
			if childData["type"] == "Element" then
				local childElement = setmetatable(childData, Element)
				childElement:Construct(newObject)
			else
			
				local childElement = setmetatable(childData, Element)
				childElement:ConstructFragment(newObject)
			end
		end
	end

	if this.Events then
		for eventName, eventValue in pairs(this.Events) do
			if string.lower(eventName) == "change" then
				for _eventName, _eventValue in pairs(eventValue) do
					newObject:GetPropertyChangedSignal(_eventName):Connect(function()
						_eventValue(newObject[_eventName], newObject)
					end)
				end
			else
				if type(eventValue) == "function" then
					newObject[eventName]:Connect(function(...)
						eventValue(..., newObject)
					end)
				end
			end
		end
	end

	if this.Animations then
		
		local newInfo
		
		
		for animKey, animVal in pairs(this.Animations) do
			if string.lower(animKey) == "transition" then
				newInfo = animVal
			end

			if string.lower(animKey) == "animations" or string.lower(animKey) == "anim" or string.lower(animKey) == "animation" then
				if typeof(animVal) == "table" then
					for _, animation: types.UVAnim in ipairs(animVal) do
						table.insert(animation.objects, newObject)
						print(animation.objects)
					end
				else
					table.insert(animVal.objects, newObject)
				end
			end
		end
		
		if not newInfo then
			newInfo = animClass.Transition.new()
		end
		
		newInfo.duration = newInfo.duration or 1
		newInfo.delay = newInfo.delay or 0
		newInfo.reverses = newInfo.reverses or false
		newInfo.repeatCount = newInfo.repeatCount or 0
		newInfo.easingStyle = newInfo.easingStyle or Enum.EasingStyle.Linear
		newInfo.easingDirection = newInfo.easingDirection or Enum.EasingDirection.In

		newInfo = TweenInfo.new(newInfo.duration, newInfo.easingStyle, newInfo.easingDirection, newInfo.repeatCount, newInfo.reverses, newInfo.delay)
		

		
		for animKey, animVal in pairs(this.Animations) do
			
			
			--// THIS IS A PURE EVENT
			if type(animKey) == "string" then
				local s,r = pcall(function()
					newObject[animKey]:Connect(function(...)

					end)
				end)
				
				if not s then continue end
				
				newObject[animKey]:Connect(function(...)
					for propName, propValue in pairs(animVal) do
						if typeof(propValue) ~= "table" then
							TweenService:Create(
								newObject,
								newInfo,
								{
									[propName] = propValue
								}
							):Play()
						else
							for innerPropName, innerPropValue in pairs(propValue) do
								TweenService:Create(
									newObject,
									newInfo,
									{
										[innerPropName] = innerPropValue
									}
								):Play()
								
								task.wait(newInfo.DelayTime or 0)
							end
						end
					end
				end)
			end
		end
	end

	if Constructor then
		if not newObject then return end
		this.onConstruction(newObject)
		newObject.Parent = Constructor
	end
	
	
	return newObject
end


return Element