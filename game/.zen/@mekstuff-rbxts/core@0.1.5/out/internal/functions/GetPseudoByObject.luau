-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    18/12/2024 18:47:13
	
]]
local GenerateRandomString = TS.import(script, script.Parent, "GenerateRandomString").GenerateRandomString
local GetPseudoById = TS.import(script, script.Parent, "GetPseudoById").GetPseudoById
local _typeIs = TS.import(script, script.Parent, "typeIs")._typeIs
local _PseudoIdentificationAttrServerName = `__pseudo_session_{GenerateRandomString(4)}__`
local function GetPseudoFromObject(Object)
	local _object = Object
	if typeof(_object) == "Instance" then
		local attr = Object:GetAttribute(_PseudoIdentificationAttrServerName)
		if type(attr) == "string" then
			return GetPseudoById(attr)
		end
	elseif _typeIs(Object, "Pseudo") then
		return Object
	end
end
return {
	GetPseudoFromObject = GetPseudoFromObject,
	_PseudoIdentificationAttrServerName = _PseudoIdentificationAttrServerName,
}
