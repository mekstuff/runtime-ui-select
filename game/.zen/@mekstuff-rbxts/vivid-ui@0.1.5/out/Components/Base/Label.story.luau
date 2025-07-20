-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 19:50:10
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Label = TS.import(script, script.Parent, "Label").Label
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
local Controls = {
	Text = "Label",
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Label, _attributes)
end)
