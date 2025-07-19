-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local isThreader = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "threader").out).isThreader
--custom typeIs
local function _typeIs(Object, Type)
	local _object = Object
	if typeof(_object) == "Instance" then
		local _object_1 = Object
		local _type = Type
		return typeof(_object_1) == _type
	end
	local s, r = pcall(function()
		local _object_1 = Object
		if typeof(_object_1) == "table" then
			local _value = Type == "SignalConnection" and Object._internal_private_isSignalConnection
			if _value ~= 0 and _value == _value and _value ~= "" and _value then
				return true
			end
			if Type == "threader" and isThreader(Object) then
				return true
			end
			local sv = Object
			if sv == nil then
				return false
			end
			if sv._dev then
				return sv:IsA(Type)
			end
		end
		return false
	end)
	if s == true then
		if r == true then
			return r
		end
	else
		warn(`An error occurred while running custom typeIs, Will fall back to default typeIs. "{r}"`, debug.traceback())
	end
	local _object_1 = Object
	local _type = Type
	return typeof(_object_1) == _type
end
return {
	_typeIs = _typeIs,
}
