-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 20:01:44
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local ToggleSwitch = TS.import(script, script.Parent, "ToggleSwitch").ToggleSwitch
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
local Controls = {
	toggled = false,
	disabled = false,
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(ToggleSwitch, _attributes)
end)
