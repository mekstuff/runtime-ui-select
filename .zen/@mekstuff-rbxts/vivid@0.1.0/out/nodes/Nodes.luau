-- Compiled with roblox-ts v3.0.0-dev-d48bd20
--[[
	
	    Typed with ❤️ @mekstuff
	    31/12/2024 08:33:17
	
]]
local ActiveNodes = {}
local function AddActiveNode(NodeType, NodeData)
	ActiveNodes[NodeType] = ActiveNodes[NodeType] or {}
	local _exp = (ActiveNodes[NodeType])
	local _nodeData = NodeData
	table.insert(_exp, _nodeData)
	return NodeData
end
local function RemoveActiveNode(NodeType, NodeData)
	local targetGroup = ActiveNodes[NodeType]
	if targetGroup == nil then
		return nil
	end
	local _nodeData = NodeData
	local _arg0 = (table.find(targetGroup, _nodeData) or 0) - 1
	table.remove(targetGroup, _arg0 + 1)
end
local function GetLatestActiveNode(NodeType)
	local targetGroup = ActiveNodes[NodeType]
	if targetGroup == nil then
		return nil
	end
	return targetGroup[#targetGroup]
end
local function RemoveAllActiveNodes(NodeType)
	ActiveNodes[NodeType] = nil
end
-- createElement
local function GetElementNode()
	return GetLatestActiveNode("ElementNode")
end
local function RemoveElementNode(Node)
	RemoveActiveNode("ElementNode", Node)
end
local function CompareElementNode(Node)
	return GetElementNode() == Node
end
local function CreateElementNode(NodeServant)
	local Node
	Node = {
		servant = NodeServant,
		addLifeCycleEvent = function(ev, cb)
			if Node._dead == true then
				return nil
			end
			Node.lifecycles = Node.lifecycles or {}
			Node.lifecycles[ev] = Node.lifecycles[ev] or {}
			local _exp = Node.lifecycles[ev]
			local _cb = cb
			table.insert(_exp, _cb)
		end,
	}
	AddActiveNode("ElementNode", Node)
	return Node
end
-- createEffect
local function GetEffectNode()
	return GetLatestActiveNode("EffectNode")
end
local function RemoveEffectNode(Node)
	return RemoveActiveNode("EffectNode", Node)
end
local function ClearAllEffectNodes()
	RemoveAllActiveNodes("EffectNode")
end
local function CreateEffectNode(add_dependency, add_cleanup, ReusableEffectNode)
	if ReusableEffectNode then
		AddActiveNode("EffectNode", ReusableEffectNode)
		return ReusableEffectNode
	end
	local Node = {
		add_dependency = add_dependency,
		add_cleanup = add_cleanup,
		effect_dependencies_size = 0,
	}
	AddActiveNode("EffectNode", Node)
	return Node
end
--[[
	
	// createState
	type StateNode = object;
	export function GetStateNode(): StateNode | undefined {
		return GetLatestActiveNode<StateNode>("StateNode");
	}
	export function RemoveStateNode(Node: StateNode) {
		return RemoveActiveNode("StateNode", Node);
	}
	export function CreateStateNode(): StateNode {
		const Node: StateNode = {};
		AddActiveNode("StateNode", Node);
		return Node;
	}
	
]]
-- lifecycle
local function GetlifecycleNode()
	return GetLatestActiveNode("lifecycleNode")
end
local function RemoveLifecycleNode(Node)
	return RemoveActiveNode("lifecycleNode", Node)
end
local function CreatelifecycleNode(cycle)
	local Node = {
		cycle = cycle,
	}
	AddActiveNode("lifecycleNode", Node)
	return Node
end
return {
	AddActiveNode = AddActiveNode,
	RemoveActiveNode = RemoveActiveNode,
	GetLatestActiveNode = GetLatestActiveNode,
	GetElementNode = GetElementNode,
	RemoveElementNode = RemoveElementNode,
	CompareElementNode = CompareElementNode,
	CreateElementNode = CreateElementNode,
	GetEffectNode = GetEffectNode,
	RemoveEffectNode = RemoveEffectNode,
	ClearAllEffectNodes = ClearAllEffectNodes,
	CreateEffectNode = CreateEffectNode,
	GetlifecycleNode = GetlifecycleNode,
	RemoveLifecycleNode = RemoveLifecycleNode,
	CreatelifecycleNode = CreatelifecycleNode,
}
