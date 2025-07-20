-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    13/05/2025 17:08:40
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local withProps = _vivid.withProps
local Button = TS.import(script, script.Parent, "Base").Button
local function Badge(props)
	local Properties = withProps(props, true)
	local _attributes = {
		roundness = 1,
		color = "primary",
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.XY,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.fromScale(1.5, 0),
		Size = UDim2.fromScale(0, 0),
		Text = "1",
		padding = { UDim.new(0, 5), UDim.new(0, 2), UDim.new(0, 5), UDim.new(0, 2) },
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		AutoButtonColor = false,
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Button, _attributes)
end
return {
	Badge = Badge,
}
