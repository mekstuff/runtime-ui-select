-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    15/06/2025 11:24:41
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local MenuBarButton = TS.import(script, script.Parent, "MenuBarButton").MenuBarButton
local Controls = {}
return CreateStory(Controls, function(props)
	return Vivid.createElement(MenuBarButton)
end)
