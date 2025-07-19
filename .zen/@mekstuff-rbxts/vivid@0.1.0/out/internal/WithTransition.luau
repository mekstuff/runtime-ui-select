-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    09/05/2025 17:30:45
	
]]
local _typeIs = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out.internal.functions.typeIs)._typeIs
local IsStatePropertyValue = TS.import(script, script.Parent.Parent, "create", "createState").IsStatePropertyValue
local IsInternalFragment = TS.import(script, script.Parent, "Fragment").IsInternalFragment
local function IsWithTransitionDef(Input)
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
	if Input._isWithTransition == true then
		return true
	end
	return false
end
--[[
	*
	 * Animate Properties within a function property
	 *
	 * ```ts
	 * <frame BackgroundTransparency={() => WithTransition(1)}/>
	 * ```
	 *
	 * @param Damping Defaults to `1`.
	 
]]
local function WithTransition(Value, DampingOrProps, Frequency, InitialValue, DefaultValue)
	local WithTransitionDef
	local _dampingOrProps = DampingOrProps
	if type(_dampingOrProps) == "number" then
		local _object = {
			_isWithTransition = true,
			_targetValue = Value,
			_initialValue = InitialValue,
			_defaultValue = DefaultValue,
		}
		local _left = "_damping"
		local _condition = DampingOrProps
		if _condition == nil then
			_condition = 1
		end
		_object[_left] = _condition
		_object._frequency = Frequency
		WithTransitionDef = _object
	else
		local _object = {
			_isWithTransition = true,
			_targetValue = Value,
		}
		local _left = "_initialValue"
		local _result = DampingOrProps
		if _result ~= nil then
			_result = _result.InitialValue
		end
		_object[_left] = _result
		local _left_1 = "_defaultValue"
		local _result_1 = DampingOrProps
		if _result_1 ~= nil then
			_result_1 = _result_1.DefaultValue
		end
		_object[_left_1] = _result_1
		local _left_2 = "_damping"
		local _result_2 = DampingOrProps
		if _result_2 ~= nil then
			_result_2 = _result_2.Damping
		end
		local _condition = _result_2
		if _condition == nil then
			_condition = 1
		end
		_object[_left_2] = _condition
		local _left_3 = "_frequency"
		local _result_3 = DampingOrProps
		if _result_3 ~= nil then
			_result_3 = _result_3.Frequency
		end
		_object[_left_3] = _result_3
		WithTransitionDef = _object
	end
	return WithTransitionDef
end
return {
	IsWithTransitionDef = IsWithTransitionDef,
	WithTransition = WithTransition,
}
