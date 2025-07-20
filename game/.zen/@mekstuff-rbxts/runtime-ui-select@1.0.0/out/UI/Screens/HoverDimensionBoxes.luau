-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 23:48:09
	
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
local DimensionBox = TS.import(script, script.Parent.Parent, "Components", "DimensionBox").DimensionBox
local function HoverDimensionBoxes()
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	return Vivid.createElement(Switch, {
		conditional = createEffect(function()
			return SettingsContext.ShowDimensionsOnHover.get() == true
		end)(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		return Vivid.createElement("screengui", {
			Name = `{Constants.PluginDisplayName} - HoverDimensions`,
			Parent = PlayerGui,
			DisplayOrder = Constants.ScreenGuiDisplayOrderLimit - 1,
			ResetOnSpawn = false,
		}, Vivid.createElement(For, {
			each = CurrentlyHoveringItems(),
			children = function(props)
				return Vivid.createElement(DimensionBox, {
					Adornee = props,
					PrimaryColor = Theme().MainButton,
					BackgroundColor = Theme().MainBackground,
					ShowAbsoluteSize = SettingsContext.ShowAbsoluteSizeOnHover.get(),
					ShowAbsolutePosition = SettingsContext.ShowAbsolutePositionOnHover.get(),
					ShowInstanceName = SettingsContext.ShowInstanceNameOnHover.get(),
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
	HoverDimensionBoxes = HoverDimensionBoxes,
}
