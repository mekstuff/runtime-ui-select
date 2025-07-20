-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 20:37:51
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local LabelledCheckbox = TS.import(script, script.Parent, "LabelledCheckbox").LabelledCheckbox
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Controls = {
	toggled = false,
	Text = "Labelled Checkbox",
}
return CreateStory(Controls, function(props)
	return Vivid.createElement(LabelledCheckbox, {
		checkboxProps = {
			toggled = props.toggled,
		},
		labelProps = {
			Text = props.Text,
		},
	})
end)
