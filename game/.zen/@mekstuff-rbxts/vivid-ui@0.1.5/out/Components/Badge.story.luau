-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    13/05/2025 17:09:06
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Badge = TS.import(script, script.Parent, "Badge").Badge
local Button = TS.import(script, script.Parent, "Base").Button
local Controls = {
	icon = "",
	loading = false,
	disabled = false,
	Text = "1",
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Button, {
		loading = true,
		Text = "Badge Wrapped Inside Of A Folder",
	}, Vivid.createElement("folder", nil, Vivid.createElement(Badge, _attributes)))
end)
