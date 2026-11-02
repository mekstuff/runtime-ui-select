-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Drawer = TS.import(script, script.Parent, "Drawer").Drawer
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
-- import { EnumList } from "@rbxts/ui-labs";
local Controls = {
	opened = true,
	scale = 0.75,
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Drawer, _attributes)
end)
