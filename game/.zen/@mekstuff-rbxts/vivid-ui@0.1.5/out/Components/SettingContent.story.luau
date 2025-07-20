-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 20:40:05
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local SettingContent = TS.import(script, script.Parent, "SettingContent").SettingContent
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local ToggleSwitch = TS.import(script, script.Parent, "Base").ToggleSwitch
local Controls = {
	titleText = "Title",
	hideSplitter = false,
	Visible = true,
	LayoutOrder = 0,
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(SettingContent, _attributes, Vivid.createElement(ToggleSwitch, {
		toggled = true,
	}))
end)
