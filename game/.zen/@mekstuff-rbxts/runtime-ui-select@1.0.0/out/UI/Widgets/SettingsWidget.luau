-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 22:18:19
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createScope = _vivid.createScope
local Suspense = _vivid.Suspense
local use = _vivid.use
local Constants = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Constants").Constants
local GetPlugin = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "GetPlugin").GetPlugin
local GetIsRunningSession = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "GetUsageContext").GetIsRunningSession
local SettingsScreen = TS.import(script, script.Parent.Parent, "Screens", "SettingsScreen").SettingsScreen
local ToolTip = TS.import(script, script.Parent.Parent, "Screens", "ToolTip").ToolTip
local function SettingsWidget(props)
	return Vivid.createElement(Suspense, nil, function()
		local Widget = GetPlugin():CreateDockWidgetPluginGui(`{Constants.PluginWidgetIdentifierPrefix}_{math.random()}`, DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 300, 450, 300, 450))
		Widget.Title = `{Constants.PluginDisplayName}{if GetIsRunningSession() then " - Client" else ""}`
		Widget.Enabled = true
		if GetPlugin():GetSetting(Constants.PluginSharedSettingsKey) == nil then
			-- FTUE
			Widget.Enabled = true
		end
		local SettingsWidgetButton = use(function()
			return props.Toolbar
		end):CreateButton(Constants.PluginDisplayName, "Select GUI During Runtime.", use(function()
			return Constants.Dynamic_PluginDisplayIcon()
		end))
		local DynamicIconScope = createScope()
		createEffect(function()
			SettingsWidgetButton.Icon = Constants.Dynamic_PluginDisplayIcon()
		end)
		DynamicIconScope.Close()
		SettingsWidgetButton.Click:Connect(function()
			Widget.Enabled = not Widget.Enabled
		end)
		Vivid.createElement("frame", {
			Parent = Widget,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, Vivid.createElement(SettingsScreen), Vivid.createElement(ToolTip, {
			MainWidget = Widget,
		}))
		return Widget
	end)
end
return {
	SettingsWidget = SettingsWidget,
}
