-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/01/2025 01:24:29
	
]]
local onDismount = TS.import(script, script.Parent.Parent, "lifecycles", "onDismount").onDismount
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local GetEffectNode = _Nodes.GetEffectNode
local GetElementNode = _Nodes.GetElementNode
local function createCleanup(Callback)
	-- use cleanup inside createEffect
	local EffectNode = GetEffectNode()
	if EffectNode ~= nil then
		EffectNode.add_cleanup(Callback)
		return nil
	end
	-- use cleanup inside createElement
	local ElementNode = GetElementNode()
	if ElementNode ~= nil then
		onDismount(function()
			Callback(true)
		end)
		return nil
	end
	error("You can only use createCleanup() inside a createElement() or createEffect()")
end
return {
	createCleanup = createCleanup,
}
