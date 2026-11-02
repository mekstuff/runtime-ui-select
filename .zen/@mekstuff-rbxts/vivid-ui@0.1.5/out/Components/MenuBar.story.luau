-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    15/06/2025 11:24:41
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local MenuBar = TS.import(script, script.Parent, "MenuBar").MenuBar
local MenuBarButton = TS.import(script, script.Parent, "MenuBarButton").MenuBarButton
local Icons = TS.import(script, script.Parent.Parent, "Icons").Icons
local Controls = {}
return CreateStory(Controls, function(props)
	return Vivid.createElement(Vivid.Fragment, nil, Vivid.createElement(MenuBar), Vivid.createElement(MenuBar, nil, Vivid.createElement(MenuBarButton, {
		Text = "File",
	}), Vivid.createElement(MenuBarButton, {
		Text = "Edit",
	})), Vivid.createElement(MenuBar, nil, Vivid.createElement(MenuBarButton, {
		icon = Icons.fromName("fluency", "outline", "add-plus"),
		Text = "Add",
	}), Vivid.createElement(MenuBarButton, {
		icon = Icons.fromName("fluency", "outline", "edit-subtract"),
		Text = "Remove",
	})))
end)
