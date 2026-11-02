-- Compiled with roblox-ts v3.0.0
local ROBLOX_STRING_ATTRIBUTE_LENGTH_LIMIT = 50
--[[
	*
	 * Gets the string value to be displayed as an attribute, will truncate the text to fit the roblox limits. (If input isn't a string, it will just return back the value.)
	 *
	 
]]
local function GetAttributeStringValue(input, warnExceededLimit)
	return input
	-- if (typeIs(input, "string") !== true) {
	-- 	return input;
	-- }
	-- if (input.size() <= ROBLOX_STRING_ATTRIBUTE_LENGTH_LIMIT) {
	-- 	return input;
	-- }
	-- if (warnExceededLimit !== undefined) {
	-- 	warn(
	-- 		`GetAttributeStringValue exceeded limit of ${ROBLOX_STRING_ATTRIBUTE_LENGTH_LIMIT} for value "${input}". ${warnExceededLimit}`,
	-- 	);
	-- }
	-- return `${input.sub(1, 47)}...` as T;
end
return {
	GetAttributeStringValue = GetAttributeStringValue,
}
