-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _pseudo
--[[
	*
	 * Creates a new `CreatePseudoClientReplicator`. Needed to prevent circular dependency.
	 
]]
local function CreatePseudoClientReplicator(pseudoOriginator)
	if _pseudo then
		return _pseudo.PseudoClientReplicator.new(pseudoOriginator)
	end
	local ImportSuccess, Pseudo = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent.Parent.Parent))
	end):await()
	if ImportSuccess == false then
		error("Could not import Pseudo.")
	end
	_pseudo = Pseudo
	return Pseudo.PseudoClientReplicator.new(pseudoOriginator)
end
return {
	CreatePseudoClientReplicator = CreatePseudoClientReplicator,
}
