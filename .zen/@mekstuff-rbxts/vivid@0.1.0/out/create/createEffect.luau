-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    29/12/2024 21:50:10
	
]]
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local RemoveEffectNode = _Nodes.RemoveEffectNode
local CreateEffectNode = _Nodes.CreateEffectNode
local GetElementNode = _Nodes.GetElementNode
local GetEffectNode = _Nodes.GetEffectNode
local createCleanup = TS.import(script, script.Parent, "createCleanup").createCleanup
local createState = TS.import(script, script.Parent, "createState").createState
local RunService = game:GetService("RunService")
--[[
	*
	 * If any State is called within your `Callback`, it will rerun your `Callback` anytime that state changes.
	 *
	 * @param [AccurateDependencyExecution=false] By default, if your effect has multiple dependencies, You callback will execute only at the end of the frame and will only run once. Meaning if two dependent states
	 * changes at the same time, instead of running the function twice, it will run only once with the updated values being correct. However, setting this to true will make the function
	 * run twice, where the first function will see state1 be up to date but state2 not technically "updated", then another execution where both states are "updated".
	 
]]
local function createEffect(Callback, DefaultValue, AccurateDependencyExecution)
	if AccurateDependencyExecution == nil then
		AccurateDependencyExecution = false
	end
	local ExistingEffectNode = GetEffectNode()
	if ExistingEffectNode ~= nil then
		error("Attempted to createEffect within createEffect.")
	end
	local ElementNode = GetElementNode()
	if ElementNode == nil then
		error("Attempted to createEffect outside of an Element or a Scope.")
	end
	local createEffectState
	local setcreateEffectState
	if DefaultValue ~= nil then
		local create, set = createState(DefaultValue)
		createEffectState = create
		setcreateEffectState = set
	end
	local INITIAL_EFFECT_NODE
	local CURRENT_TEMP_NODE
	local NoShallowErrorTraceback = debug.traceback()
	local CreateEffectCallbackParam = setmetatable({
		exit = function()
			-- A user can call .end() inside their createEffect to remove the effect node
			-- this is for cases where they want to for e.g. call a function that creates an element
			-- or does some kind of logic that is not permitted inside of a createEffect.
			if INITIAL_EFFECT_NODE ~= nil then
				RemoveEffectNode(INITIAL_EFFECT_NODE)
			end
			if CURRENT_TEMP_NODE ~= nil then
				RemoveEffectNode(CURRENT_TEMP_NODE)
			end
		end,
		cleanup = function(cb)
			local _cb = cb
			local _arg0 = type(_cb) == "function"
			local _arg1 = `CreateEffectCallbackParam.cleanup cb not a function`
			assert(_arg0, _arg1)
			return createCleanup(cb)
		end,
	}, {
		__call = function(_, cb)
			local _cb = cb
			local _arg0 = type(_cb) == "function"
			local _arg1 = `CreateEffectCallbackParam.__call cb not a function`
			assert(_arg0, _arg1)
			return createCleanup(cb)
		end,
	})
	local RunCallback = function(isInitalRun)
		local CallbackExecuted = false
		task.defer(function()
			if CallbackExecuted == false then
				-- We check for any yields within this callback for the createEffect and throw an error if any.
				-- Check if CallbackExecuted was set to true at the end of the frame.
				error(`[createEffect() Yield] Do you have yielding code within your createEffect function? task.wait, WaitForChild, etc. cannot be used within a createEffect function unless within a safe thread.\n\ntraceback:\n\n{NoShallowErrorTraceback}`)
			end
		end)
		if ElementNode._dead == true then
			CallbackExecuted = true
			return nil
		end
		local Results = Callback(CreateEffectCallbackParam)
		CallbackExecuted = true
		if Results == nil and createEffectState == nil then
			return nil
		end
		if createEffectState == nil and isInitalRun == true then
			local create, set = createState(Results)
			createEffectState = create
			setcreateEffectState = set
		end
		if isInitalRun == false then
			setcreateEffectState(Results)
		end
	end
	local add_cleanup = function(cleanupCallback)
		INITIAL_EFFECT_NODE.effect_cleanups = INITIAL_EFFECT_NODE.effect_cleanups or {}
		local _effect_cleanups = INITIAL_EFFECT_NODE.effect_cleanups
		local _cleanupCallback = cleanupCallback
		table.insert(_effect_cleanups, _cleanupCallback)
	end
	local _EFFECT_TRACEBACK_PATH = if RunService:IsStudio() == true then debug.traceback() else "[[ UNAVAILALE_IN_LIVE_GAME ]]"
	-- So that the function only executes a single time per frame
	local CallbackExecution
	local ExecutingCallback = false
	local function ExecuteCallbackOneFrame(Callback)
		CallbackExecution = Callback
		if ExecutingCallback == true then
			return nil
		end
		ExecutingCallback = true
		-- TODO: in cases with like 3+ dependencies, this logic kind of breaks and reruns function
		task.defer(function()
			if CallbackExecution ~= nil then
				local s, r = pcall(function()
					return CallbackExecution()
				end)
				if s == nil then
					error(`error occurred while executing createEffect:\n-----\n{r}\n-----\nTraceback:\n-----\n{_EFFECT_TRACEBACK_PATH}`)
				end
			end
			CallbackExecution = nil
			ExecutingCallback = false
		end)
		-- Since we are running on a different thread, we need to return the cleanup here even if `CallbackExecution` returns it.
		return function(...)
			local args = { ... }
			-- Only matter for `Destroying`
			local _result = INITIAL_EFFECT_NODE.effect_cleanups
			if _result ~= nil then
				-- ▼ ReadonlyArray.forEach ▼
				local _callback = function(x)
					return x(unpack(args))
				end
				for _k, _v in _result do
					_callback(_v, _k - 1, _result)
				end
				-- ▲ ReadonlyArray.forEach ▲
			end
			local _result_1 = INITIAL_EFFECT_NODE.effect_cleanups
			if _result_1 ~= nil then
				table.clear(_result_1)
			end
		end
	end
	local add_dependency
	local function CallbackExecuteInObserverFunc()
		-- Run any cleanups now since the initial function did run
		if INITIAL_EFFECT_NODE.effect_cleanups and #INITIAL_EFFECT_NODE.effect_cleanups > 0 then
			local _result = INITIAL_EFFECT_NODE.effect_cleanups
			if _result ~= nil then
				-- ▼ ReadonlyArray.forEach ▼
				local _callback = function(x)
					return x()
				end
				for _k, _v in _result do
					_callback(_v, _k - 1, _result)
				end
				-- ▲ ReadonlyArray.forEach ▲
			end
			local _result_1 = INITIAL_EFFECT_NODE.effect_cleanups
			if _result_1 ~= nil then
				table.clear(_result_1)
			end
		end
		-- rerun the effect from the next time the state changes.
		CURRENT_TEMP_NODE = CreateEffectNode(add_dependency, add_cleanup, INITIAL_EFFECT_NODE)
		RunCallback(false)
		RemoveEffectNode(CURRENT_TEMP_NODE)
		CURRENT_TEMP_NODE = nil
		if INITIAL_EFFECT_NODE.effect_cleanups and #INITIAL_EFFECT_NODE.effect_cleanups > 0 then
			return function(...)
				local args = { ... }
				-- Only matter for `Destroying`
				local _result = INITIAL_EFFECT_NODE.effect_cleanups
				if _result ~= nil then
					-- ▼ ReadonlyArray.forEach ▼
					local _callback = function(x)
						return x(unpack(args))
					end
					for _k, _v in _result do
						_callback(_v, _k - 1, _result)
					end
					-- ▲ ReadonlyArray.forEach ▲
				end
				local _result_1 = INITIAL_EFFECT_NODE.effect_cleanups
				if _result_1 ~= nil then
					table.clear(_result_1)
				end
			end
		end
	end
	-- adds the state as a dependency of this createEffect
	add_dependency = function(depedency)
		if INITIAL_EFFECT_NODE == nil then
			error("Cannot find INITIAL_EFFECT_NODE to add_dependency")
		end
		if INITIAL_EFFECT_NODE.disable_dependency_injection == true then
			return nil
		end
		INITIAL_EFFECT_NODE.effect_dependencies = INITIAL_EFFECT_NODE.effect_dependencies or {}
		local dependencies = INITIAL_EFFECT_NODE.effect_dependencies
		if dependencies[depedency] == true then
			-- state is already a dependency, do not observe.
			return nil
		end
		INITIAL_EFFECT_NODE.effect_dependencies_size += 1
		dependencies[depedency] = true
		local Observer = depedency:ObserveNext(function()
			if INITIAL_EFFECT_NODE.effect_dependencies_size > 1 and AccurateDependencyExecution == false then
				-- multiple dependencies, run on next frame
				return ExecuteCallbackOneFrame(CallbackExecuteInObserverFunc)
			else
				-- print("calling function");
				return CallbackExecuteInObserverFunc()
			end
		end, { "State" })
		if ElementNode ~= nil then
			-- If there's a root createElement, this createEffect Observers should be bounded to it so they get cleaned up with it
			ElementNode.servant:Keep(Observer)
		end
	end
	INITIAL_EFFECT_NODE = CreateEffectNode(add_dependency, add_cleanup)
	RunCallback(true)
	ElementNode.servant:Keep(function()
		-- Run cleanups once the ElementNode servant is Destroyed
		-- due to the fact that the dependencies may not be initiaited before the root is removed.
		local _result = INITIAL_EFFECT_NODE.effect_cleanups
		if _result ~= nil then
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(x)
				return x(true)
			end
			for _k, _v in _result do
				_callback(_v, _k - 1, _result)
			end
			-- ▲ ReadonlyArray.forEach ▲
		end
		local _result_1 = INITIAL_EFFECT_NODE.effect_cleanups
		if _result_1 ~= nil then
			table.clear(_result_1)
		end
	end)
	RemoveEffectNode(INITIAL_EFFECT_NODE)
	return createEffectState
end
return {
	createEffect = createEffect,
}
