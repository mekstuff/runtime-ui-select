-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    29/04/2025 12:27:52
	
]]
local createRef = TS.import(script, script.Parent.Parent, "create", "createRef").createRef
local _createElement = TS.import(script, script.Parent.Parent, "create", "createElement")
local createElement = _createElement.createElement
local withProps = _createElement.withProps
local onMount = TS.import(script, script.Parent.Parent, "lifecycles", "onMount").onMount
local createCleanup = TS.import(script, script.Parent.Parent, "create", "createCleanup").createCleanup
local function ZIndexLayer(props)
	local LayerRef = createRef()
	onMount(function()
		local UpdateZIndexLayer
		UpdateZIndexLayer = function(Children, Level)
			if Level == nil then
				Level = 1
			end
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(Child)
				if Child:IsA("GuiObject") == false then
					return nil
				end
				Child.ZIndex = LayerRef().ZIndex + Level
				UpdateZIndexLayer(Child:GetChildren(), Level + 1)
			end
			for _k, _v in Children do
				_callback(_v, _k - 1, Children)
			end
			-- ▲ ReadonlyArray.forEach ▲
		end
		local DescendantAddedConnection = LayerRef().DescendantAdded:Connect(function()
			UpdateZIndexLayer(LayerRef():GetChildren())
		end)
		local DescendantRemovingConnection = LayerRef().DescendantRemoving:Connect(function()
			UpdateZIndexLayer(LayerRef():GetChildren())
		end)
		LayerRef():GetPropertyChangedSignal("ZIndex"):Connect(function()
			UpdateZIndexLayer(LayerRef():GetChildren())
		end)
		createCleanup(function()
			DescendantAddedConnection:Disconnect()
			DescendantRemovingConnection:Disconnect()
		end)
		UpdateZIndexLayer(LayerRef():GetChildren())
	end)
	local _object = {
		ref = LayerRef,
		BackgroundTransparency = 1,
	}
	for _k, _v in withProps(props, true) do
		_object[_k] = _v
	end
	return createElement("Frame", _object, props.children)
end
return {
	ZIndexLayer = ZIndexLayer,
}
