-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    19/07/2025 15:10:44
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local _vivid_ui = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out)
local Button = _vivid_ui.Button
local Icons = _vivid_ui.Icons
local Theme = _vivid_ui.Theme
local function UnavailableFeature()
	return Vivid.createElement(Button, {
		props = {
			IconImage = {
				ImageColor3 = Theme().ErrorText,
			},
		},
		icon = Icons.fromName("fluency", "outline", "warning-error"),
		variant = "ghost",
		Interactable = false,
		Text = "",
		BackgroundTransparency = 1,
	})
end
return {
	UnavailableFeature = UnavailableFeature,
}
