-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    05/08/2025 13:48:38
	
]]
local _typeIs = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out.internal.functions.typeIs)._typeIs
local IsStatePropertyValue = TS.import(script, script.Parent.Parent, "create", "createState").IsStatePropertyValue
local IsInternalFragment = TS.import(script, script.Parent, "Fragment").IsInternalFragment
local function IsWithSuspenseDef(Input)
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
	if Input._isWithSuspense == true then
		return true
	end
	return false
end
--[[
	*
	 * Use within a createEffect that is used for a `createElement` property. If Callback is a function, it will be wrapped in a Promise.try().
	 *
	 * ```ts
	 * <frame BackgroundTransparency={() => {
	 * 	return withSuspense(() => {
	 * 		task.wait(2)
	 * 		return 1 // BackgroundTransparency will change to `1` from `0.5` after `2` seconds.
	 * 	}, 0.5)
	 * }}/>
	 * ```
	 
]]
local function WithSuspense(Callback, DefaultValue, ErrorValue)
	local WithSuspenseDef = {
		_isWithSuspense = true,
		_exec_promise = if TS.Promise.is(Callback) then Callback else TS.Promise.try(Callback),
		_default_value = DefaultValue,
		_error_value = ErrorValue,
	}
	return WithSuspenseDef
end
return {
	IsWithSuspenseDef = IsWithSuspenseDef,
	WithSuspense = WithSuspense,
}
