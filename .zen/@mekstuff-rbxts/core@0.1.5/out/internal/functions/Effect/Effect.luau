-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    26/03/2026 00:11:55
	
]]
local Servant = TS.import(script, script.Parent.Parent.Parent.Parent, "class", "Servant", "Servant").Servant
local tryUseEffectCleanup = TS.import(script, script.Parent.Parent, "CalluseEffectServant").tryUseEffectCleanup
local CurrentEffectFunctionObject = nil
local function _CreateReactivePseudo(object)
	return object
end
--[[
	*
	 * Makes any direct index of the Pseudo provided reactive (Your effect will re-render whenever the property of whatever you indexed changes)
	 *
	 * e.g.
	 *
	 * ```ts
	 * Effect((r) => {
	 * 	r(Compatibility).GamepadEnabled;
	 * 	print(gamepadEnabled);
	 * 	// Reruns function anytime "GamepadEnabled" for "Compatibility" changes.
	 * })
	 * ```
	 
]]
--[[
	*
	 * Use call method on `State` objects within your callback to inject them as dependencies.
	 *
	 * Effects are always ran at the start of the next frame.
	 *
	 * ```ts
	 * const State = new State(1)
	 *
	 * Effect(() => {
	 * 	print(State()) // 1, then 2 after delay
	 * })
	 *
	 * task.delay(.5, () => {
	 * 	State.SetState(2)
	 * })
	 *
	 * ```
	 *
	 * @param callback Will rerun when any state dependency that is called within the function state changes.
	 * @returns
	 
]]
local function EffectFunction(callback)
	local destroyed = false
	local cleanup = nil
	local effectServant = Servant.new()
	local injectedStates = {}
	local reactivePseudosMap = {}
	local effectObject, runCallback
	effectObject = {
		Destroy = function()
			if destroyed == true then
				return nil
			end
			if CurrentEffectFunctionObject == effectObject then
				CurrentEffectFunctionObject = nil
			end
			destroyed = true
			tryUseEffectCleanup(cleanup, true)
			effectServant:Destroy()
			-- ▼ ReadonlyMap.forEach ▼
			local _callback = function(x)
				setmetatable(x, nil)
				table.clear(x)
			end
			for _k, _v in reactivePseudosMap do
				_callback(_v, _k, reactivePseudosMap)
			end
			-- ▲ ReadonlyMap.forEach ▲
			table.clear(reactivePseudosMap)
			table.clear(injectedStates)
			table.freeze(injectedStates)
			table.clear(effectObject)
			table.freeze(effectObject)
		end,
		_inject_state = function(stateObject)
			if destroyed == true then
				return nil
			end
			local _stateObject = stateObject
			if (table.find(injectedStates, _stateObject) or 0) - 1 > -1 then
				return nil
			end
			local _stateObject_1 = stateObject
			table.insert(injectedStates, _stateObject_1)
			effectServant:Keep(stateObject:ObserveNext(function()
				runCallback()
			end, { "State" }))
		end,
		_servant = effectServant,
		_reactive_pseudos_map = reactivePseudosMap,
	}
	local createReactivePseudo = function(input)
		if destroyed == true then
			return nil
		end
		local __reactive_pseudos_map = effectObject._reactive_pseudos_map
		local _input = input
		local cachedMapObject = __reactive_pseudos_map[_input]
		if cachedMapObject ~= nil then
			return cachedMapObject
		end
		local trackedPropertiesRecord = {}
		local reactiveObject = setmetatable({}, {
			__index = function(_, key)
				trackedPropertiesRecord[key] = true
				return input[key]
			end,
		})
		effectServant:Keep(input.PropertyChanged:Connect(function(key)
			if trackedPropertiesRecord[key] ~= true then
				return nil
			end
			-- rerender
			runCallback()
		end))
		local __reactive_pseudos_map_1 = effectObject._reactive_pseudos_map
		local _input_1 = input
		__reactive_pseudos_map_1[_input_1] = reactiveObject
		return reactiveObject
	end
	runCallback = function()
		task.delay(0, function()
			tryUseEffectCleanup(cleanup)
			if destroyed == true then
				return nil
			end
			CurrentEffectFunctionObject = effectObject
			cleanup = callback(createReactivePseudo)
			CurrentEffectFunctionObject = if CurrentEffectFunctionObject == effectObject then nil else CurrentEffectFunctionObject
		end)
	end
	runCallback()
	return effectObject
end
local function getCurrentRunningEffectObject()
	return CurrentEffectFunctionObject
end
return {
	getCurrentRunningEffectObject = getCurrentRunningEffectObject,
	Effect = EffectFunction,
}
