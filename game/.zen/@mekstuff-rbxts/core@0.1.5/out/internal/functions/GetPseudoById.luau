-- Compiled with roblox-ts v3.0.0
local PseudoCollector = {}
--[[
	*
	 * Searches for the pseudo by the id, if no pseudo matches the id then returns nil
	 
]]
local function GetPseudoById(PseudoId)
	local _pseudoId = PseudoId
	local _exp = type(_pseudoId) == "string"
	local _pseudoId_1 = PseudoId
	local _arg1 = `PseudoId expected to be a string, got {typeof(_pseudoId_1)}`
	assert(_exp, _arg1)
	local t = PseudoCollector[PseudoId]
	return t
end
return {
	GetPseudoById = GetPseudoById,
	PseudoCollector = PseudoCollector,
}
