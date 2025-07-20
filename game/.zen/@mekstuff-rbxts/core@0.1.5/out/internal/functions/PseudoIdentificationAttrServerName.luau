-- Compiled with roblox-ts v3.0.0
--[[
	*
	 * Generate a random string for id
	 * Change
	 
]]
local function GenerateRandomString(length)
	local CHARSARRAY = {}
	local CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz"
	for i = 1, #CHARS do
		local _i = i
		local _i_1 = i
		local _arg0 = string.sub(CHARS, _i, _i_1)
		table.insert(CHARSARRAY, _arg0)
	end
	if length == nil then
		length = 10
	end
	local str = ""
	do
		local i = 1
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
return `_pseudo{GenerateRandomString(4)}`
