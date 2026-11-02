-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    15/06/2025 11:23:36
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Box = _vivid.Box
local createEffect = _vivid.createEffect
local withProps = _vivid.withProps
local _Utils = TS.import(script, script.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local function MenuBar(props)
	local Properties = withProps(props, true)
	Properties.children = nil
	local _attributes = {
		Size = createEffect(function()
			return UDim2.new(1, 0, 0, Units().BaseOffsetHeight * 0.8)
		end)(),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		BackgroundColor3 = Theme().ScriptBackground,
		BorderSizePixel = 0,
		Padding = UDim.new(0, 1),
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Box, _attributes, props.children)
end
return {
	MenuBar = MenuBar,
}
