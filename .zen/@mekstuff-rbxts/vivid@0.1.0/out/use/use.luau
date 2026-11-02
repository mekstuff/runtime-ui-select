-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    16/02/2025 23:27:11
	
]]
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local CreateEffectNode = _Nodes.CreateEffectNode
local RemoveEffectNode = _Nodes.RemoveEffectNode
local CreateEffectNodeFuncDep = function()
	return nil
end
--[[
	*
	 * Useful reactive values without making them become a dependency/causing reruns of the function. The function will return the value of the item returned by your function
	 * at the given time.
	 
]]
local function use(input)
	local EffectNode = CreateEffectNode(CreateEffectNodeFuncDep, CreateEffectNodeFuncDep)
	local Results = input()
	RemoveEffectNode(EffectNode)
	return Results
end
return {
	use = use,
}
