-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    23/01/2025 14:01:49
	
		TODO: IMPORTANT! Attempting to createScope at root then createElement directly below cause the parent of the element to not be
		properly assigned? RECREATION CODE:
	
		createScope();
		
		const [State, setState] = createState("Demonstration");
		
		const Element = createElement("Frame", {
			Parent: game.GetService("ReplicatedStorage"),
		});
		
		print(Element);
	
]]
local Servant = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out).Servant
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local CreateElementNode = _Nodes.CreateElementNode
local GetEffectNode = _Nodes.GetEffectNode
local RemoveElementNode = _Nodes.RemoveElementNode
local SCOPE_ENTRIES = {}
--[[
	*
	 * A scope can be used to bind components/elements to a servant. Any createEffects/Elements
	 * created while the scope is Opened will bind to it. Similar to how createEffects and States
	 * will bind the createElement
	 *
	 * @param BoundToElementNode If defined, will return that bounded element node and does not create a seperate Element node for the scope but
	 * replaces the servant of the bounded node with the servant of the a new Servant while the scope is opened. When closed, the bounded element node will return
	 * to the previous state. When the scope is closed, the bounded element node *WILL NOT* be destroyed.
	 * `Close()` does not call `RemoveElementNode` if `BoundToElementNode` is defined.
	 
]]
local function createScope(ElementNodeRef)
	--[[
		
			if (HAS_ACTIVE_SCOPE === true) {
				throw "Attempted to createScope within createScope.";
			}
			if (GetElementNode() !== undefined) {
				throw "Attempted to createScope within createElement";
			}
			
	]]
	if GetEffectNode() ~= nil then
		error("Attempted to createScope within createEffect")
	end
	local ScopeServant = Servant.new()
	local ActiveScopeNode = CreateElementNode(ScopeServant)
	if ElementNodeRef ~= nil then
		ElementNodeRef._element_node_ref = ActiveScopeNode
	end
	local ScopeObject
	ScopeObject = {
		Opened = true,
		Open = function()
			if ScopeObject.Opened == true then
				return nil
			end
			ScopeObject.Opened = true
			ActiveScopeNode = CreateElementNode(ScopeServant)
		end,
		Close = function()
			if ActiveScopeNode == nil then
				error("Scope cannot be closed due to Element Node is not defined.")
			end
			ScopeObject.Opened = false
			RemoveElementNode(ActiveScopeNode)
		end,
		Destroy = function()
			local _arg0 = (table.find(SCOPE_ENTRIES, ScopeServant) or 0) - 1
			table.remove(SCOPE_ENTRIES, _arg0 + 1)
			ScopeObject.Close()
			ScopeServant:Destroy()
		end,
		Servant = ScopeServant,
	}
	table.insert(SCOPE_ENTRIES, ScopeServant)
	return ScopeObject
end
local function clearScopes()
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(x)
		return x:Destroy()
	end
	for _k, _v in SCOPE_ENTRIES do
		_callback(_v, _k - 1, SCOPE_ENTRIES)
	end
	-- ▲ ReadonlyArray.forEach ▲
	table.clear(SCOPE_ENTRIES)
end
return {
	createScope = createScope,
	clearScopes = clearScopes,
}
