-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    31/12/2024 13:45:36
	
]]
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local RemoveLifecycleNode = _Nodes.RemoveLifecycleNode
local CompareElementNode = _Nodes.CompareElementNode
local CreatelifecycleNode = _Nodes.CreatelifecycleNode
local GetElementNode = _Nodes.GetElementNode
--[[
	*
	 *
	 * Passing an onWillDismount lifecycle changes an element - Instead of returning the raw roblox instance, you're given a proxy object. You can
	 * index and newindex the object like it's a normal roblox instance. This allows you to execute code when .Destroy is called on the "Instance", allowing features
	 * like animation presence (animating out the object before it is completely destroyed.) onWillDismount callbacks can yield, the actual Instance isn't destroyed until
	 * all callbacks are completed. It is recommended to return a Promise instead of yielding within your onWillDismount callback,
	 * With a `Promise`, the lifecycle will end whenever the Promise is resolved or rejected.
	 *
	 * @param Callback The callback function that will run.
	 *
	 * The "Component" provided as an argument in your callback will be the component that .Destroy was called on, not the current actual component. use onMount to store a ref of the component
	 * if you wish to use the actual component.
	 
]]
local function onWillDismount(Callback)
	local ElementNode = GetElementNode()
	if ElementNode == nil or CompareElementNode(ElementNode) == false then
		error(`Attempted to use onWillDismount invalidly. Make sure you're calling onWillDismount wthin a createElement function`)
	end
	ElementNode.addLifeCycleEvent("onWillDismount", function(...)
		local args = { ... }
		local LCN = CreatelifecycleNode("onWillDismount")
		local res = Callback(unpack(args))
		RemoveLifecycleNode(LCN)
		return res
	end)
end
return {
	onWillDismount = onWillDismount,
}
