-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 20:48:15
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Toast = TS.import(script, script.Parent, "Toast").Toast
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Choose = TS.import(script, TS.getModule(script, "@rbxts", "ui-labs").src).Choose
local Controls = {
	id = game:GetService("HttpService"):GenerateGUID(),
	lifetime = 10,
	color = Choose({ "none", "info", "danger", "warning" }, 1),
	Text = "Toast",
	buttonHidden = false,
	icon = "rbxassetid://11422925441",
	viewDisplay = Choose({ "dynamic", "viewport", "widget", "mirror" }),
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Toast, _attributes)
end)
