-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Drawer = TS.import(script, script.Parent, "Drawer").Drawer
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
local EnumList = TS.import(script, TS.getModule(script, "@rbxts", "ui-labs").src).EnumList
local Controls = {
	opened = true,
	scale = 0.75,
	verticalAlignment = EnumList({
		Top = Enum.VerticalAlignment.Top,
		Center = Enum.VerticalAlignment.Center,
		Bottom = Enum.VerticalAlignment.Bottom,
	}, "Bottom"),
	horizontalAlignment = EnumList({
		Left = Enum.HorizontalAlignment.Left,
		Center = Enum.HorizontalAlignment.Center,
		Right = Enum.HorizontalAlignment.Right,
	}, "Center"),
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Drawer, _attributes)
end)
