-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local GetAttributeStringValue = TS.import(script, script.Parent, "GetAttributeStringValue").GetAttributeStringValue
local RunService = game:GetService("RunService")
local function UpdateAttrValueForPseudoInstance(objectProxy, key, value)
	local typedObjectProxy = objectProxy
	-- Display attributes ( only in studio )
	if RunService:IsStudio() and typedObjectProxy._ref ~= nil then
		if key == "Name" or key == "Parent" then
			return nil
		end
		local _key = key
		local _condition = type(_key) == "string"
		if _condition then
			local _condition_1 = (string.match(key, "^_"))
			if not (_condition_1 ~= 0 and _condition_1 == _condition_1 and _condition_1 ~= "" and _condition_1) then
				_condition_1 = (string.match(key, "^%$"))
			end
			_condition = _condition_1
		end
		if _condition ~= 0 and _condition == _condition and _condition ~= "" and _condition then
			return nil
		end
		typedObjectProxy._attr_set_data = typedObjectProxy._attr_set_data or {}
		if typedObjectProxy._attr_set_data[key] ~= nil then
			return nil
		end
		typedObjectProxy._attr_set_data[key] = true
		local success = pcall(function()
			typedObjectProxy._ref:SetAttribute(key, GetAttributeStringValue(value))
		end)
		if success ~= true then
			local __ref = typedObjectProxy._ref
			local _exp = key
			local _value = value
			__ref:SetAttribute(_exp, GetAttributeStringValue(`** {typeof(_value)}: {value} **`))
		end
		typedObjectProxy._attr_set_data[key] = nil
	end
end
return {
	UpdateAttrValueForPseudoInstance = UpdateAttrValueForPseudoInstance,
}
