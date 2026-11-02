-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--* TODO: THIS MODULE IS NO LONGER BEING USED, REMOVE 
local GetAttributeStringValue = TS.import(script, script.Parent, "GetAttributeStringValue").GetAttributeStringValue
local _typeIs = TS.import(script, script.Parent, "typeIs")._typeIs
local IgnoreAssignAttributesToKeys = { "Parent" }
--*
local function AssignAttributeValue(ReferenceInstance, key, value)
	local _key = key
	if type(_key) == "string" then
		if (string.match(key, "^_")) ~= nil then
			return nil
		end
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(e)
			return e == key
		end
		local _result
		for _i, _v in IgnoreAssignAttributesToKeys do
			if _callback(_v, _i - 1, IgnoreAssignAttributesToKeys) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		if _result ~= nil then
			return nil
		end
		local success, reason = pcall(function()
			if _typeIs(value, "Pseudo") then
				if value:IsA("Signal") then
					return nil
				end
				ReferenceInstance:SetAttribute(key, GetAttributeStringValue(`***{tostring(value)}***`))
			else
				ReferenceInstance:SetAttribute(key, GetAttributeStringValue(value))
			end
		end)
		-- make a somewhat important check using string match when the error message could be changed by ROBLOX anytime soon? why not.
		local _value = type(reason) == "string" and (string.match(string.lower(reason), "^attribute name contains illegal character"))
		if _value ~= 0 and _value == _value and _value ~= "" and _value then
			return nil
		end
		if not success then
			ReferenceInstance:SetAttribute(key, GetAttributeStringValue(`***{reason}***`))
		end
	end
end
return {
	AssignAttributeValue = AssignAttributeValue,
}
