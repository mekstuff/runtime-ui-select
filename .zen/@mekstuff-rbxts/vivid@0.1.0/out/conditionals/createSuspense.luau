-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    01/01/2025 23:11:22
	
]]
local createState = TS.import(script, script.Parent.Parent, "create", "createState").createState
local createElement = TS.import(script, script.Parent.Parent, "create", "createElement").createElement
local createEffect = TS.import(script, script.Parent.Parent, "create", "createEffect").createEffect
local createSwitch = TS.import(script, script.Parent, "createSwitch").createSwitch
local _FragmentIdentifier_ = TS.import(script, script.Parent.Parent, "internal", "Fragment")._FragmentIdentifier_
local function DefaultSuspenseErrHandler()
	return createElement(_FragmentIdentifier_)
end
local function createPromiseSuspense(SuspensePromise, Content, Loading, Err, BooleanConsidered)
	local PromiseStatus, setPromiseStatus = createState("Started")
	local _CURRENT_PROMISE
	createEffect(function()
		local PromiseObject = SuspensePromise()
		_CURRENT_PROMISE = PromiseObject
		PromiseObject:finally(function()
			local Status = PromiseObject:getStatus()
			local PromiseObjectValue = PromiseObject:expect()
			if BooleanConsidered == true and type(PromiseObjectValue) == "boolean" then
				setPromiseStatus(if PromiseObjectValue then "Resolved" else "Stale")
				return nil
			end
			setPromiseStatus(Status)
		end)
	end)
	return createSwitch(PromiseStatus).Case("Started", function()
		if Loading == nil then
			return createElement(_FragmentIdentifier_)
		end
		return createElement(Loading, _CURRENT_PROMISE:expect())
	end).Case("Resolved", function()
		return createElement(Content, _CURRENT_PROMISE:expect())
	end).Case("Rejected", function()
		if Err == nil then
			return createElement(_FragmentIdentifier_)
		end
		return createElement(Err or DefaultSuspenseErrHandler, _CURRENT_PROMISE:expect())
	end).Case("Stale", function()
		return createElement(_FragmentIdentifier_)
	end)
end
--[[
	*
	 * Will call the Content function inside a Promise, Note that the Content function is not wrapped in a createElement(). It is called directly inside the Promise.
	 *
	 * This allows you to have yielding code inside of an element
	 *
	 * e.g.
	 *
	 * return <> <Suspense>{() => task.wait(1); return <textlabel/>}</Suspense> </>
	 
]]
local function createSuspense(Content, Loading, Err)
	local PromiseStatus, setPromiseStatus = createState("Started")
	local Switch = createSwitch(PromiseStatus()).Case("Started", Loading or DefaultSuspenseErrHandler).Case("Rejected", Err or DefaultSuspenseErrHandler)
	local TargetPromise = TS.Promise.new(function(resolve)
		setPromiseStatus("Started")
		-- const ContentRendered = createElement(Content);
		local ContentRendered = Content()
		Switch.Case("Resolved", function()
			return ContentRendered
		end)
		resolve()
	end)
	TargetPromise:finally(function()
		setPromiseStatus(TargetPromise:getStatus())
	end)
	return Switch
end
return {
	createPromiseSuspense = createPromiseSuspense,
	createSuspense = createSuspense,
}
