-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    19/05/2025 00:15:27
	
		TODO: - Add CreateResponsiveGroup function that creates an object that can contain it's own breakpoint values and it's on container. You should be able to pass the group as the "container" for Responsive() props.
	
]]
local State = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out).State
local _typeIs = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out.internal.functions.typeIs)._typeIs
local IsStatePropertyValue = TS.import(script, script.Parent.Parent, "create", "createState").IsStatePropertyValue
local IsInternalFragment = TS.import(script, script.Parent, "Fragment").IsInternalFragment
local ResponsiveBreakpoints = { {
	responsive = "sm",
	breakpoint = 460,
}, {
	responsive = "md",
	breakpoint = 768,
}, {
	responsive = "lg",
	breakpoint = 1024,
}, {
	responsive = "xl",
	breakpoint = 1280,
}, {
	responsive = "xl2",
	breakpoint = 1536,
} }
local function GetResponsiveGroup(Size)
	for index = #ResponsiveBreakpoints - 1, 1, -1 do
		local Target = ResponsiveBreakpoints[index + 1]
		if Target.breakpoint < Size.X then
			return Target.responsive
		end
	end
	return "sm"
end
local ResponsiveSizesStatesMap = {}
local function IsResponsiveObject(Input)
	local _input = Input
	if type(_input) == "table" == false then
		return false
	end
	if _typeIs(Input, "Pseudo") then
		return false
	end
	if IsStatePropertyValue(Input) == true then
		return false
	end
	if IsInternalFragment(Input) == true then
		return false
	end
	if Input._is_responsive_object == true then
		return true
	end
	return false
end
local function Responsive(props)
	local container = props.container or game:GetService("Workspace").CurrentCamera
	local _arg1 = `Could not resolve Responsive container, input: {container}`
	assert(container, _arg1)
	local TargetGroupListenerState = ResponsiveSizesStatesMap[container]
	if TargetGroupListenerState == nil then
		TargetGroupListenerState = State.new("sm")
		TargetGroupListenerState._dev._responsive_usage_total = 0
		local SizeUpdated = function(Size)
			local _result = TargetGroupListenerState
			if _result ~= nil then
				_result:setState(GetResponsiveGroup(Size))
			end
		end
		if container:IsA("Camera") then
			TargetGroupListenerState._dev.insert(container:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				SizeUpdated(container.ViewportSize)
			end))
			SizeUpdated(container.ViewportSize)
		else
			TargetGroupListenerState._dev.insert(container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				SizeUpdated(container.AbsoluteSize)
			end))
			SizeUpdated(container.AbsoluteSize)
		end
		local _targetGroupListenerState = TargetGroupListenerState
		ResponsiveSizesStatesMap[container] = _targetGroupListenerState
	end
	local ResponsiveEntries = {}
	local AddResponsiveEntry = function(GroupName, Value)
		if Value == nil then
			return nil
		end
		local _arg0 = ResponsiveEntries[GroupName] == nil
		local _arg1_1 = `Already assigned responsive value to "{GroupName}"`
		assert(_arg0, _arg1_1)
		ResponsiveEntries[GroupName] = Value
	end
	local ResponsiveObject = {
		_is_responsive_object = true,
		_group_state = TargetGroupListenerState,
		_responsive = ResponsiveEntries,
		_increment_usage_total = function()
			TargetGroupListenerState._dev._responsive_usage_total += 1
		end,
		_decrement_usage_total = function()
			TargetGroupListenerState._dev._responsive_usage_total -= 1
			task.defer(function()
				if (TargetGroupListenerState._dev._responsive_usage_total) > 0 then
					return nil
				end
				ResponsiveSizesStatesMap[container] = nil
				TargetGroupListenerState:Destroy()
			end)
		end,
	}
	local _condition = props.md
	if _condition == nil then
		_condition = props.sm
	end
	local md = _condition
	local _condition_1 = props.lg
	if _condition_1 == nil then
		_condition_1 = md
	end
	local lg = _condition_1
	local _condition_2 = props.xl
	if _condition_2 == nil then
		_condition_2 = lg
	end
	local xl = _condition_2
	local _condition_3 = props.xl2
	if _condition_3 == nil then
		_condition_3 = xl
	end
	local xl2 = _condition_3
	AddResponsiveEntry("sm", props.sm)
	AddResponsiveEntry("md", md)
	AddResponsiveEntry("lg", lg)
	AddResponsiveEntry("xl", xl)
	AddResponsiveEntry("xl2", xl2)
	return ResponsiveObject
end
return {
	IsResponsiveObject = IsResponsiveObject,
	Responsive = Responsive,
}
