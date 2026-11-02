-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 19:49:17
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Input = TS.import(script, script.Parent, "Input").Input
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
-- import { Choose } from "@rbxts/ui-labs";
local Controls = {
	Text = "Input",
	roundness = 0,
	padding = 0,
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Input, _attributes)
end)
