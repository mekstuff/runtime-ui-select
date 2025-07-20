-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    18/12/2024 18:48:20
	
]]
local CHARSARRAY
--[[
	*
	 * Generate a random string for id
	 * Change
	 
]]
local function GenerateRandomString(length)
	if length == nil then
		length = 10
	end
	if not CHARSARRAY then
		CHARSARRAY = {}
		local CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz"
		for i = 0, #CHARS do
			local _cHARSARRAY = CHARSARRAY
			local _i = i
			local _i_1 = i
			local _arg0 = string.sub(CHARS, _i, _i_1)
			table.insert(_cHARSARRAY, _arg0)
		end
	end
	local str = ""
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < length) then
				break
			end
			str = str .. CHARSARRAY[math.random(1, #CHARSARRAY - 1) + 1]
		end
	end
	return str
end
return {
	GenerateRandomString = GenerateRandomString,
}
