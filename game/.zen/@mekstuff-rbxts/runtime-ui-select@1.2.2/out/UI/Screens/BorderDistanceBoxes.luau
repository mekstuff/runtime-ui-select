-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    18/07/2025 17:49:16
	
]]
local Players = game:GetService("Players")
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Case = _vivid.Case
local createEffect = _vivid.createEffect
local For = _vivid.For
local Switch = _vivid.Switch
local Theme = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out).Theme
local CurrentlyHoveringItems = TS.import(script, script.Parent.Parent.Parent, "Contexts", "RuntimeContexts").CurrentlyHoveringItems
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local Constants = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Constants").Constants
local BorderDistanceBox = TS.import(script, script.Parent.Parent, "Components", "BorderDistanceBox").BorderDistanceBox
local function BorderDistanceBoxes()
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	return Vivid.createElement(Switch, {
		conditional = createEffect(function()
			return SettingsContext.ShowBorderBoxesOnHover.get() == true
		end)(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		return Vivid.createElement("screengui", {
			Name = `{Constants.PluginDisplayName} - BorderDistances`,
			Parent = PlayerGui,
			DisplayOrder = Constants.ScreenGuiDisplayOrderLimit - 2,
			ResetOnSpawn = false,
		}, Vivid.createElement(For, {
			each = CurrentlyHoveringItems(),
			children = function(props)
				return Vivid.createElement(BorderDistanceBox, {
					Adornee = props,
					BackgroundColor3 = Theme().MainButton,
					TextColor3 = Theme().MainText,
				})
			end,
		}))
	end), Vivid.createElement(Case, {
		condition = false,
	}, function()
		return Vivid.createElement(Vivid.createFragment)
	end))
end
return {
	BorderDistanceBoxes = BorderDistanceBoxes,
}
