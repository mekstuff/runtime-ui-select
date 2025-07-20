-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local ModalPrompt = TS.import(script, script.Parent, "ModalPrompt").ModalPrompt
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local LoremIpsum = TS.import(script, script.Parent.Parent, "Utils", "LoremIpsum").LoremIpsum
local Button = TS.import(script, script.Parent, "Base").Button
local Controls = {
	title = "Modal",
	body = LoremIpsum(250),
	opened = true,
}
return CreateStory(Controls, function(props)
	local _attributes = {
		buttons = { Vivid.createElement(Button, {
			color = "default",
			Text = "Cancel",
		}), Vivid.createElement(Button, {
			loading = true,
			color = "primary",
			Text = "Accept",
		}) },
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement(ModalPrompt, _attributes)
end)
