-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    31/12/2024 13:28:26
	
]]
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local RemoveLifecycleNode = _Nodes.RemoveLifecycleNode
local CompareElementNode = _Nodes.CompareElementNode
local CreatelifecycleNode = _Nodes.CreatelifecycleNode
local GetElementNode = _Nodes.GetElementNode
local function onWillMount(Callback)
	local ElementNode = GetElementNode()
	if ElementNode == nil or CompareElementNode(ElementNode) == false then
		error(`Attempted to use onWillMount invalidly. Make sure you're calling onWillMount wthin a createElement function`)
	end
	ElementNode.addLifeCycleEvent("onWillMount", function()
		local LCN = CreatelifecycleNode("onWillMount")
		Callback()
		RemoveLifecycleNode(LCN)
	end)
end
return {
	onWillMount = onWillMount,
}
