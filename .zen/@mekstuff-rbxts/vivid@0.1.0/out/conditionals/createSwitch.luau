-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local createElement = TS.import(script, script.Parent.Parent, "create", "createElement").createElement
local createScope = TS.import(script, script.Parent.Parent, "create", "createScope").createScope
local _createState = TS.import(script, script.Parent.Parent, "create", "createState")
local createState = _createState.createState
local IsStatePropertyValue = _createState.IsStatePropertyValue
local GetElementNode = TS.import(script, script.Parent.Parent, "nodes", "Nodes").GetElementNode
local IsInternalFragment = TS.import(script, script.Parent.Parent, "internal", "Fragment").IsInternalFragment
local IsInternalProxyInstance = TS.import(script, script.Parent.Parent, "internal", "ProxyInstance").IsInternalProxyInstance
--[[
	*
	 *
	 * @param Condition A State
	 * @param Truthy Optional shorthand for if Condition is true.
	 * @param Falsy Optional shorthand for if Condition is false.
	 * @returns SwitchStatementReturn, Can be called and used as a State and/or be a chainable object that contains `.Case` and `.Default`.
	 *
	 * e.g. createSwitch(State).Case(true, ...).Case(false, ...).Case(1, ...)
	 *
	 * Cases can also use functions that expect a boolean to be returned to specify if the condition is met. The Condition value will be passed as the first param.
	 *
	 * e.g. createSwitch(State: boolean).Case((State: boolean) => State === true, ...) --> Whenever "State" is true, the Case will be rendered.
	 * e.g. createSwitch(State: number).Case((State: boolean) => State > 1, ...) --> Whenever "State" is more than 1, the Case will be rendered.
	 *
	 * For jsx:
	 *
	 * <Switch condition={...}>
	 * 	<Case>() => createElement(...)</Case>
	 * </Switch>
	 
]]
local function createSwitch(Condition, Truthy, Falsy)
	local SwitchElementNode = GetElementNode()
	if SwitchElementNode == nil then
		error(`You may be using createSwitch() incorrectly. It should be used somewhere inside a createElement call.`)
	end
	local ActiveSwitch, setActiveSwitch, _internalState = createState(nil)
	local _entries = {}
	local UpdateSwitchElement = function(value)
		local _value = value
		local _exp = type(_value) == "function"
		local _value_1 = value
		local _arg1 = `createSwitch() Cases child should be a function, got {typeof(_value_1)}`
		assert(_exp, _arg1)
		local ItemCreationScope = createScope(SwitchElementNode)
		SwitchElementNode.servant:Keep(ItemCreationScope)
		local renderedItem = createElement(value)
		setActiveSwitch(renderedItem)
		ItemCreationScope.Close()
	end
	local UpdateSwitch = function(_val)
		local _RESOLVED_ = false
		if _internalState:IsDestroyed() == true then
			-- The ActiveSwitch object was Destroyed before the UpdateSwitch function was called
			return nil
		end
		if SwitchElementNode._dead == true then
			-- The SwitchElementNode object was Destroyed before the UpdateSwitch function was called
			return nil
		end
		for key, value in pairs(_entries) do
			if type(key) == "function" then
				local res = key(_val)
				local _arg0 = type(res) == "boolean"
				local _arg1 = `expected boolean from Switch condition function, got {typeof(res)} "{res}"`
				assert(_arg0, _arg1)
				if res == true then
					UpdateSwitchElement(value)
					_RESOLVED_ = true
					return nil
				end
			else
				if _val == key then
					UpdateSwitchElement(value)
					_RESOLVED_ = true
					return nil
				end
			end
			if _RESOLVED_ == true then
				return nil
			end
			if _val ~= nil and _val ~= false and Truthy ~= nil then
				-- Truthy
				UpdateSwitchElement(Truthy)
				return nil
			end
			if Falsy ~= nil then
				-- Falsy
				UpdateSwitchElement(Falsy)
				return nil
			end
			local _default = _entries["_.default"]
			if _default ~= nil then
				UpdateSwitchElement(_default)
				return nil
			end
		end
		warn(`createSwitch() has no condition for Case "{_val}"`)
		setActiveSwitch(nil)
	end
	local _IsSwitchActivated = false
	local SwitchMetaTable
	SwitchMetaTable = setmetatable({
		Case = function(condition, value)
			if _entries[condition] ~= nil then
				error(`Condition "{condition}" was already applied to the switch statement.`)
			end
			_entries[condition] = value
			return SwitchMetaTable
		end,
		Default = function(value)
			if _entries["_.default"] ~= nil then
				error(`Condition "_.default" was already applied to the switch statement.`)
			end
			_entries["_.default"] = value
			return SwitchMetaTable
		end,
	}, {
		__call = function()
			if _IsSwitchActivated == true then
				return nil
			end
			if IsStatePropertyValue(Condition) == false then
				local _condition = Condition
				error(`The Condition inputted isn't a StatePropertyValue! Got {typeof(_condition)} createSwitch expects Condition to be a StatePropertyValue`)
			end
			_internalState._dev.insert(Condition._state:Observe(function()
				task.defer(function()
					if Condition._state == nil then
						-- State removed before deferred function ran.
						return nil
					end
					-- Defer to attempt to fix bugs where the createSwitch UpdateSwitch() will attempt to run before effect nodes closed. (Patch: 5/30/2025)
					-- Similar fix applied to forEach update function.
					UpdateSwitch(Condition._state.State)
				end)
			end, { "State" }))
			_IsSwitchActivated = true
			return ActiveSwitch()
		end,
	})
	local onInternalStateObserve
	onInternalStateObserve = function(targetState, nested)
		return targetState:Observe(function()
			local _StateObjectValue = targetState.State
			local __StateObjectValue = _StateObjectValue
			local _condition = not (typeof(__StateObjectValue) == "Instance")
			if _condition then
				_condition = not IsStatePropertyValue(_StateObjectValue) and not IsInternalFragment(_StateObjectValue) and not IsInternalProxyInstance(_StateObjectValue)
			end
			if _condition then
				return nil
			end
			local _TargetStateObjectInstance = if IsStatePropertyValue(_StateObjectValue) then (_StateObjectValue._state.State) else _StateObjectValue
			local NestedStateObserver
			if IsStatePropertyValue(_StateObjectValue) then
				-- Switch is using a state as the child/what should be rendered.
				-- e.g. -> a conditional having a child conditional / a state that value is another state.
				-- print("nested");
				NestedStateObserver = onInternalStateObserve(_StateObjectValue._state, true)
			end
			return function()
				-- print(_TargetStateObjectInstance);
				if NestedStateObserver then
					NestedStateObserver:Destroy()
					local _StateObjectValueTyped = _StateObjectValue
					if _StateObjectValueTyped._state ~= nil then
						_StateObjectValueTyped._state:Destroy()
					end
					return nil
				end
				if _TargetStateObjectInstance ~= nil then
					_TargetStateObjectInstance:Destroy()
				end
			end
		end, { "State" })
	end
	onInternalStateObserve(_internalState, false)
	return SwitchMetaTable
end
return {
	createSwitch = createSwitch,
}
