-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _servant
--[[
	*
	 * Creates a new `Servant`. Needed to prevent circular dependency.
	 
]]
local function CreateServant()
	if _servant then
		return _servant.Servant.new()
	end
	local ImportSuccess, Servant = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent.Parent.Parent, "class", "Servant", "Servant"))
	end):await()
	if ImportSuccess == false then
		error("Could not import Servant.")
	end
	_servant = Servant
	return Servant.Servant.new()
end
return {
	CreateServant = CreateServant,
}
