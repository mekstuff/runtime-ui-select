-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 22:21:35
	
]]
local Icons = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out).Icons
local PluginDisplayName = "Runtime UI Select"
local Constants = {
	PluginDisplayName = PluginDisplayName,
	PluginDisplayIcon = Icons.fromName("fluency", "outline", "mouse-cursor-click"),
	PluginWidgetIdentifierPrefix = "runtime-ui-select",
	PluginSharedSettingsKey = "PluginSharedSettings",
	PluginSharedSettingTokenListener = `{PluginDisplayName}-PluginSharedSettingTokenListener`,
	MainWidgetToolTipCollectionId = "MainWidgetToolTipCollectionId",
	ScreenGuiDisplayOrderLimit = 2147483647,
}
return {
	Constants = Constants,
}
