-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    19/12/2024 19:42:34
	
]]
local GetLuaProvider
local function RequireTS(ModuleScript)
	return GetLuaProvider().require(ModuleScript)
end
function GetLuaProvider()
	local _result = script.Parent
	if _result ~= nil then
		_result = _result.Parent
		if _result ~= nil then
			_result = _result.Parent
			if _result ~= nil then
				_result = _result:FindFirstChild("lua-provider")
				if _result ~= nil then
					_result = _result:FindFirstChild("LuaProvider")
				end
			end
		end
	end
	local LuaProvider = require(_result)
	return LuaProvider
end
return {
	RequireTS = RequireTS,
	GetLuaProvider = GetLuaProvider,
}
