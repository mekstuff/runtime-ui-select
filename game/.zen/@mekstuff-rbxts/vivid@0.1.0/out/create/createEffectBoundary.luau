-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    01/01/2025 18:52:27
	
]]
local GetEffectNode = TS.import(script, script.Parent.Parent, "nodes", "Nodes").GetEffectNode
--[[
	*
	 * Use within a createEffect so that no use of states will cause a "re-render".
	 
]]
--
local function createEffectBoundary(Callback)
	local EffectNode = GetEffectNode()
	if EffectNode == nil then
		Callback()
		return nil
		-- throw `Did you use createEffectBoundary() outside of a createEffect?`;
	end
	EffectNode.effect_boundaries = EffectNode.effect_boundaries or {}
	local _effect_boundaries = EffectNode.effect_boundaries
	local _callback = Callback
	local indx = (table.find(_effect_boundaries, _callback) or 0) - 1
	if indx > -1 then
		return nil
	end
	local _effect_boundaries_1 = EffectNode.effect_boundaries
	local _callback_1 = Callback
	table.insert(_effect_boundaries_1, _callback_1)
	Callback()
end
return {
	createEffectBoundary = createEffectBoundary,
}
