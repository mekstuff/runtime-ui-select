-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    26/03/2026 09:42:38
	
]]
local _react = TS.import(script, TS.getModule(script, "@rbxts", "react"))
local useCallback = _react.useCallback
local useEffect = _react.useEffect
local useMemo = _react.useMemo
local useState = _react.useState
--[[
	*
	 * When using setState on bulk properties, the values will be set on the start of the next frame!
	 
]]
local function usePseudo(pseudo, property)
	local _property = property
	if type(_property) == "table" then
		local observeProperties = useMemo(function()
			local observeProperties = {}
			for _, value in pairs(property) do
				table.insert(observeProperties, value)
			end
			return observeProperties
		end, {})
		local observePropertiesReverseRecord = useMemo(function()
			local observePropertiesReverseRecord = {}
			for key, value in pairs(property) do
				observePropertiesReverseRecord[value] = key
			end
			return observePropertiesReverseRecord
		end, { observeProperties })
		-- usePseudo with property table list.
		local initialValue = useMemo(function()
			local results = {}
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(key)
				if observePropertiesReverseRecord[key] == nil then
					return nil
				end
				results[observePropertiesReverseRecord[key]] = pseudo[key]
			end
			for _k, _v in observeProperties do
				_callback(_v, _k - 1, observeProperties)
			end
			-- ▲ ReadonlyArray.forEach ▲
			return results
		end, { observeProperties, observePropertiesReverseRecord })
		local values, setValues = useState(initialValue)
		local pseudoOberverDisabled, setPseudoOberverDisabled = useState(false)
		useEffect(function()
			if pseudoOberverDisabled == true then
				return nil
			end
			local conn = pseudo:ObserveNext(function()
				setValues(function()
					local results = {}
					-- ▼ ReadonlyArray.forEach ▼
					local _callback = function(key)
						results[observePropertiesReverseRecord[key]] = pseudo[key]
					end
					for _k, _v in observeProperties do
						_callback(_v, _k - 1, observeProperties)
					end
					-- ▲ ReadonlyArray.forEach ▲
					return results
				end)
			end, observeProperties)
			return function()
				conn:Destroy()
			end
		end, { pseudoOberverDisabled, observeProperties, observePropertiesReverseRecord })
		local customSetValues = useCallback(function(arg)
			local newValues
			local _arg = arg
			if type(_arg) == "function" then
				local _object = table.clone(values)
				setmetatable(_object, nil)
				local _spread = arg(values)
				if _spread ~= 0 and _spread == _spread and _spread ~= "" and _spread then
					for _k, _v in _spread do
						_object[_k] = _v
					end
				end
				newValues = _object
			else
				local _object = table.clone(values)
				setmetatable(_object, nil)
				if arg then
					for _k, _v in arg do
						_object[_k] = _v
					end
				end
				newValues = _object
			end
			local filteredValues = {}
			-- We set the values here in bulk and disable individual BbserveNext detection for optimization sake.
			-- Individual observe calls will scale with the amount of properties being set, which is not ideal.
			setPseudoOberverDisabled(true)
			task.delay(0, function()
				-- ▼ ReadonlyArray.forEach ▼
				local _callback = function(key)
					pseudo:useNewIndexAssignment(key, newValues[observePropertiesReverseRecord[key]])
					filteredValues[observePropertiesReverseRecord[key]] = pseudo[key]
				end
				for _k, _v in observeProperties do
					_callback(_v, _k - 1, observeProperties)
				end
				-- ▲ ReadonlyArray.forEach ▲
				setPseudoOberverDisabled(false)
			end)
			setValues(filteredValues)
		end, { pseudo, property, observeProperties, observePropertiesReverseRecord })
		return { values, customSetValues }
	end
	-- use string to use specific single property.
	local value, setValue = useState(pseudo[property])
	local customSetValue = useCallback(function(arg)
		local _arg = arg
		if type(_arg) == "function" then
			pseudo[property] = arg(pseudo[property])
		else
			pseudo[property] = arg
		end
	end, { pseudo, property })
	useEffect(function()
		local conn = pseudo:ObserveNext(function()
			setValue(pseudo[property])
		end, { property })
		return function()
			conn:Destroy()
		end
	end, { pseudo, property })
	return { value, customSetValue }
end
return {
	usePseudo = usePseudo,
}
