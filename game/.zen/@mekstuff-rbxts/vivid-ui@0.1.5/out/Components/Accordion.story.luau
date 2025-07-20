-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    06/06/2025 19:13:34
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Box = _vivid.Box
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Accordion = TS.import(script, script.Parent, "Accordion").Accordion
local Icons = TS.import(script, script.Parent.Parent, "Icons").Icons
local Label = TS.import(script, script.Parent, "Base").Label
local Controls = {
	expanded = false,
	expandedIcon = Icons.fromName("fluency", "outline", "chevron-down"),
	collapsedIcon = Icons.fromName("fluency", "outline", "chevron-right"),
	Text = "Accordion",
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	_attributes.props = {}
	return Vivid.createElement(Accordion, _attributes, Vivid.createElement(Box, {
		alignment = Enum.HorizontalAlignment.Center,
		Size = UDim2.new(1, 0, 0, 120),
	}, Vivid.createElement(Label, {
		TextWrapped = true,
		AutomaticSize = Enum.AutomaticSize.XY,
		Text = "Accordion Content!",
	})))
end)
