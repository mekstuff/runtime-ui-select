-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    31/12/2024 13:19:45
	
]]
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local RemoveLifecycleNode = _Nodes.RemoveLifecycleNode
local CompareElementNode = _Nodes.CompareElementNode
local CreatelifecycleNode = _Nodes.CreatelifecycleNode
local GetElementNode = _Nodes.GetElementNode
local function onMount(Callback)
	local ElementNode = GetElementNode()
	if ElementNode == nil or CompareElementNode(ElementNode) == false then
		error(`Attempted to use onMount invalidly. Make sure you're calling onMount wthin a createElement function`)
	end
	ElementNode.addLifeCycleEvent("onMount", function()
		local LCN = CreatelifecycleNode("onMount")
		Callback()
		RemoveLifecycleNode(LCN)
	end)
end
return {
	onMount = onMount,
}
