-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    13/05/2025 18:07:06
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local ToastsList = TS.import(script, script.Parent, "ToastsList").ToastsList
local Controls = {}
return CreateStory(Controls, function(props)
	return Vivid.createElement(ToastsList, {
		toasts = { {
			Text = "Toast List Item",
			id = game:GetService("HttpService"):GenerateGUID(),
			buttonClicked = function(id)
				print(`Toast Button Clicked: {id}`)
			end,
		} },
	})
end)
