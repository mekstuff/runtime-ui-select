-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 19:15:08
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Button = TS.import(script, script.Parent, "Button").Button
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
local Choose = TS.import(script, TS.getModule(script, "@rbxts", "ui-labs").src).Choose
local Controls = {
	Text = "Button",
	roundness = 0,
	padding = 0,
	icon = "",
	loading = false,
	color = Choose({ "default", "danger", "primary", "success" }, 1),
	variant = Choose({ "default", "outlined", "ghost", "link" }, 1),
	disabled = false,
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Button, _attributes)
end)
