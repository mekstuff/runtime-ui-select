-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    16/07/2025 00:21:17
	
]]
local _vivid = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out")
local Vivid = _vivid.default
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createState = _vivid.createState
local use = _vivid.use
local Button = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid-ui", "out").Button
local GetIsNonPluginEnv = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "GetUsageContext").GetIsNonPluginEnv
local UnavailableFeature = TS.import(script, script.Parent, "UnavailableFeature").UnavailableFeature
local function ThemeToggleButton()
	if GetIsNonPluginEnv() == true then
		return Vivid.createElement(UnavailableFeature)
	end
	local SettingsStudio = settings().Studio
	local CurrentTheme, setCurrentTheme = createState(SettingsStudio.Theme)
	local AvailableThemes, setAvailableThemes = createState(SettingsStudio:GetAvailableThemes())
	local ThemeChangedListener = SettingsStudio.ThemeChanged:Connect(function()
		setCurrentTheme(SettingsStudio.Theme)
		setAvailableThemes(SettingsStudio:GetAvailableThemes())
	end)
	createCleanup(function()
		ThemeChangedListener:Disconnect()
	end)
	return Vivid.createElement(Button, {
		Size = UDim2.fromScale(1),
		Text = createEffect(function()
			return CurrentTheme().Name
		end),
		Activated = function()
			local CurrentAvailableThemes = use(function()
				return AvailableThemes()
			end)
			local CurrentThemeInstance = use(function()
				return CurrentTheme()
			end)
			local CurrentIndex = (table.find(CurrentAvailableThemes, CurrentThemeInstance) or 0) - 1
			local TargetIndex = if CurrentAvailableThemes[CurrentIndex + 2] == nil then 0 else CurrentIndex + 1
			SettingsStudio.Theme = CurrentAvailableThemes[TargetIndex + 1]
		end,
	})
end
return {
	ThemeToggleButton = ThemeToggleButton,
}
