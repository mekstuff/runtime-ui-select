-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Modal = TS.import(script, script.Parent, "Modal").Modal
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
local Label = TS.import(script, script.Parent, "Label").Label
local LoremIpsum = TS.import(script, script.Parent.Parent.Parent, "Utils", "LoremIpsum").LoremIpsum
local extp = TS.import(script, script.Parent.Parent.Parent, "Utils").extp
local Controls = {
	opened = true,
	scale = 0.7,
	backdropTransparency = 0.5,
}
return CreateStory(Controls, function(props)
	local _attributes = {
		props = extp({
			Backdrop = {
				Activated = function()
					print("backdrop!")
				end,
			},
		}),
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Modal, _attributes, Vivid.createElement("uipadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 6),
		PaddingRight = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 6),
	}), Vivid.createElement("uilistlayout", {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Padding = UDim.new(0, 6),
		FillDirection = Enum.FillDirection.Vertical,
	}), Vivid.createElement(Label, {
		TextWrapped = true,
		Text = `Modal Content: {LoremIpsum(250)}`,
	}))
end)
