-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    16/07/2025 22:45:10
	
]]
local _vivid = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out")
local Vivid = _vivid.default
local createScope = _vivid.createScope
local Portal = _vivid.Portal
local _vivid_ui = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid-ui", "out")
local Button = _vivid_ui.Button
local ModalPrompt = _vivid_ui.ModalPrompt
local function PromptTextOption(props)
	local PromptScope = createScope()
	Vivid.createElement(Portal, {
		slot = "#root",
	}, Vivid.createElement(ModalPrompt, {
		opened = true,
		title = props.title,
		body = props.body,
		buttons = { Vivid.createElement(Button, {
			Activated = function()
				PromptScope.Destroy()
				props.onOption(false)
			end,
			color = "default",
			Text = "Cancel",
		}), Vivid.createElement(Button, {
			Activated = function()
				PromptScope.Destroy()
				props.onOption(true)
			end,
			color = "primary",
			Text = "Accept",
		}) },
	}))
	PromptScope.Close()
end
return {
	PromptTextOption = PromptTextOption,
}
