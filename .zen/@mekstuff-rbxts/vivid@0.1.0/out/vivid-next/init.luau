-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	*
	 * Vivid-next is Vivid with exported functions and methods that use core functionality but makes it easier to develop.
	 *
	 * e.g., Creation of scopes aren't neccessary when using vivid next functions, e.g. you can create a state any where within your code
	 
]]
local WithTransition = TS.import(script, script.Parent, "internal", "WithTransition").WithTransition
local WithSuspense = TS.import(script, script.Parent, "internal", "WithSuspense").WithSuspense
local Responsive = TS.import(script, script.Parent, "internal", "Responsive").Responsive
local _FragmentIdentifier_ = TS.import(script, script.Parent, "internal", "Fragment")._FragmentIdentifier_
local GetElementNode = TS.import(script, script.Parent, "nodes", "Nodes").GetElementNode
local createScope = TS.import(script, script.Parent, "create", "createScope").createScope
local createState = TS.import(script, script.Parent, "create", "createState").createState
local createSpring = TS.import(script, script.Parent, "create", "createSpring").createSpring
local createRef = TS.import(script, script.Parent, "create", "createRef").createRef
local createSlot = TS.import(script, script.Parent, "create", "createSlot").createSlot
local createEffect = TS.import(script, script.Parent, "create", "createEffect").createEffect
local createCleanup = TS.import(script, script.Parent, "create", "createCleanup").createCleanup
local createElement = TS.import(script, script.Parent, "create", "createElement").createElement
local createSwitch = TS.import(script, script.Parent, "conditionals", "createSwitch").createSwitch
local createConditional = TS.import(script, script.Parent, "conditionals", "createConditional").createConditional
local Motion = TS.import(script, script.Parent, "functions", "Motion").Motion
local function VividNextState()
end
local VividNextScope = createScope()
local function toggleVividNextScope(state)
	if state == true then
		local HasElementNode = GetElementNode() ~= nil
		if HasElementNode == false then
			VividNextScope.Open()
		end
	else
		if VividNextScope.Opened == true then
			VividNextScope.Close()
		end
	end
end
--[[
	*
	 * Similar to `createElement` but doesn't require to be directly in a scope.
	 
]]
local function element(...)
	local args = { ... }
	toggleVividNextScope(true)
	local results = createElement(unpack(args))
	toggleVividNextScope(false)
	return results
end
--[[
	*
	 * Similar to `createRef` but doesn't require to be directly in a scope.
	 
]]
local function ref()
	toggleVividNextScope(true)
	local results = createRef()
	toggleVividNextScope(false)
	return results
end
--[[
	*
	 * Similar to `createSlot` but doesn't require to be directly in a scope.
	 
]]
local function slot(props)
	toggleVividNextScope(true)
	local results = createSlot(props)
	toggleVividNextScope(false)
	return results
end
--[[
	*
	 * Similar to `createCleanup` but doesn't require to be directly in a scope.
	 
]]
local function cleanup(Callback)
	return createCleanup(Callback)
end
--[[
	*
	 * Similar to `createState` but doesn't require to be directly in a scope.
	 *
	 * Also gives you the ability to update states directly with the `VividState` instead of using the `VividSetState`.
	 
]]
local function state(defaultValue)
	toggleVividNextScope(true)
	local StateValue, setStateValue, StateValueObject = createState(defaultValue)
	toggleVividNextScope(false)
	return function(upd)
		if upd ~= nil then
			-- updating state
			setStateValue(upd)
			return StateValueObject.State
		end
		return StateValue()
	end, setStateValue, StateValueObject
end
--[[
	*
	 * Similar to `createSpring` but doesn't require to be directly in a scope.
	 *
	 * Also gives you the ability to update states directly with the `VividState` instead of using the `VividSetState`.
	 
]]
local function spring(defaultValue, damping, frequency)
	if damping == nil then
		damping = 1
	end
	if frequency == nil then
		frequency = 1
	end
	toggleVividNextScope(true)
	local SpringValue, setSpringValue, SpringValueObject = createSpring(defaultValue, damping, frequency)
	toggleVividNextScope(false)
	return function(upd)
		if upd ~= nil then
			-- updating state
			setSpringValue(upd)
			return SpringValueObject.State
		end
		return SpringValue()
	end, setSpringValue, SpringValueObject
end
--[[
	*
	 * Similar to `createEffect` but doesn't require to be directly in a scope.
	 
]]
local function effect(callback)
	toggleVividNextScope(true)
	local effectResults = createEffect(function()
		return callback()
	end)
	toggleVividNextScope(false)
	return effectResults
end
--[[
	*
	 * Similar to `createSwitch` but doesn't require to be directly in a scope.
	 
]]
local function vswitch(...)
	local args = { ... }
	toggleVividNextScope(true)
	local switchResults = createSwitch(unpack(args))
	toggleVividNextScope(false)
	return switchResults
end
--[[
	*
	 * Similar to `createConditional` but doesn't require to be directly in a scope.
	 
]]
local function condition(...)
	local args = { ... }
	toggleVividNextScope(true)
	local conditionResults = createConditional(unpack(args))
	toggleVividNextScope(false)
	return conditionResults
end
local function transition(Value, DampingOrProps, Frequency, InitialValue, DefaultValue)
	return WithTransition(Value, DampingOrProps, Frequency, InitialValue, DefaultValue)
end
--[[
	*
	 * Similar to `Motion` but doesn't require to be directly in a scope.
	 
]]
local function motion(...)
	local args = { ... }
	toggleVividNextScope(true)
	local conditionResults = Motion(unpack(args))
	toggleVividNextScope(false)
	return conditionResults
end
local fragment = _FragmentIdentifier_
VividNextScope.Close()
return {
	element = element,
	ref = ref,
	slot = slot,
	cleanup = cleanup,
	state = state,
	spring = spring,
	effect = effect,
	vswitch = vswitch,
	condition = condition,
	transition = transition,
	motion = motion,
	suspense = WithSuspense,
	responsive = Responsive,
	fragment = fragment,
}
