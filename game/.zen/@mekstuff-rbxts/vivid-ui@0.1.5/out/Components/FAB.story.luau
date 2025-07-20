-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 20:36:42
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local FAB = TS.import(script, script.Parent, "FAB").FAB
local Controls = {
	icon = "",
	loading = false,
	disabled = false,
	Text = "Fab",
	TextSize = 20,
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(FAB, _attributes)
end)
