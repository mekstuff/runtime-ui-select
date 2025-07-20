-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Box = _vivid.Box
local createRef = _vivid.createRef
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Button = TS.import(script, script.Parent, "Base").Button
local Popover = TS.import(script, script.Parent, "Popover").Popover
local EnumList = TS.import(script, TS.getModule(script, "@rbxts", "ui-labs").src).EnumList
local Controls = {
	opened = true,
	hideArrow = false,
	scale = 0.5,
	backdropTransparency = 0.5,
	horizontalAlignment = EnumList({
		Left = Enum.HorizontalAlignment.Left,
		Center = Enum.HorizontalAlignment.Center,
		Right = Enum.HorizontalAlignment.Right,
	}, "Center"),
	verticalAlignment = EnumList({
		Top = Enum.VerticalAlignment.Top,
		Center = Enum.VerticalAlignment.Center,
		Bottom = Enum.VerticalAlignment.Bottom,
	}, "Bottom"),
}
return CreateStory(Controls, function(props)
	local Adornee = createRef()
	local _exp = Vivid.createElement(Button, {
		ref = Adornee,
		Text = "Toggle Popover",
	})
	local _attributes = {
		adornee = Adornee(),
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Box, {
		Size = UDim2.fromScale(1, 1),
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		BackgroundTransparency = 1,
	}, _exp, Vivid.createElement(Popover, _attributes, Vivid.createElement(Button, {
		Text = "Inside Popover!",
	})))
end)
