-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _PseudoReplicator
--[[
	*
	 * Creates a new `CreatePseudoReplicator`. Needed to prevent circular dependency.
	 
]]
local function CreatePseudoReplicator(args)
	if _PseudoReplicator then
		return _PseudoReplicator.PseudoReplicator.new(args)
	end
	local ImportSuccess, PseudoReplicator = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent.Parent.Parent, "class", "Replication", "PseudoReplicator"))
	end):await()
	if ImportSuccess == false then
		error("Could not import Pseudo.")
	end
	_PseudoReplicator = PseudoReplicator
	return PseudoReplicator.PseudoReplicator.new(args)
end
return {
	CreatePseudoReplicator = CreatePseudoReplicator,
}
