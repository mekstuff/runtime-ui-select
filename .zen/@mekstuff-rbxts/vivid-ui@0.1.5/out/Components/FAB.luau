-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:38:35
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Button = TS.import(script, script.Parent, "Base").Button
local function FAB(props)
	local _attributes = {
		roundness = UDim.new(1),
		BorderSizePixel = 0,
		Text = "FAB",
		padding = 10,
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Button, _attributes)
end
return {
	FAB = FAB,
}
