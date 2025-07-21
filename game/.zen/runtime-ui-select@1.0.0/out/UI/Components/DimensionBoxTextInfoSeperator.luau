-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    13/07/2025 20:22:57
	
]]
local _vivid = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out")
local Vivid = _vivid.default
local withProps = _vivid.withProps
local Theme = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid-ui", "out").Theme
local function DimensionBoxTextInfoSeperator(props)
	local _attributes = {
		Size = UDim2.new(0, 1, 1, 0),
		BackgroundColor3 = Theme().SubText,
		BorderSizePixel = 0,
	}
	for _k, _v in withProps(props, true) do
		_attributes[_k] = _v
	end
	return Vivid.createElement("frame", _attributes)
end
return {
	DimensionBoxTextInfoSeperator = DimensionBoxTextInfoSeperator,
}
