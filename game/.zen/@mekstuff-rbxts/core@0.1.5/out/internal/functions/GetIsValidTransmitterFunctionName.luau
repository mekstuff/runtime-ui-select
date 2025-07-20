-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    26/12/2024 22:36:57
	
]]
local function GetIsValidTransmitterFunctionName(Input)
	local _input = Input
	if not (type(_input) == "string") then
		return false
	end
	if (string.match(Input, "Client$")) == nil then
		return false
	end
	local firstLetter = string.sub(Input, 1, 1)
	if (string.match(firstLetter, "%a")) == nil then
		return false
	end
	if string.lower(firstLetter) ~= firstLetter then
		return false
	end
	return true
end
local _ = 7
return {
	GetIsValidTransmitterFunctionName = GetIsValidTransmitterFunctionName,
}
