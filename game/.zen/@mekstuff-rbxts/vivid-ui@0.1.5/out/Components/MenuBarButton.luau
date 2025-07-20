-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    15/06/2025 11:27:14
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local withProps = _vivid.withProps
local _Utils = TS.import(script, script.Parent.Parent, "Utils")
local extp = _Utils.extp
local Theme = _Utils.Theme
local Units = _Utils.Units
local Button = TS.import(script, script.Parent, "Base").Button
--[[
	*
	 * Used as a child of a `MenuBar` component
	 
]]
local function MenuBarButton(props)
	local Properties = withProps(props, true)
	Properties.children = nil
	local _attributes = {
		roundness = 0,
		props = extp({
			UIStroke = {
				Transparency = 1,
			},
		}, props.props),
		Text = "MenuBar Button",
		TextSize = createEffect(function()
			return Units().BaseTextSize * 0.9
		end),
		BackgroundColor3 = Theme().ScriptBackground,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromScale(0, 1),
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Button, _attributes, props.children)
end
return {
	MenuBarButton = MenuBarButton,
}
