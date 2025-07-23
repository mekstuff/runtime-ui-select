-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 22:21:35
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local createScope = _vivid.createScope
local createState = _vivid.createState
local GetIsNonPluginEnv = TS.import(script, script.Parent.Parent, "Functions", "GetUsageContext").GetIsNonPluginEnv
local PackageJSON = (if GetIsNonPluginEnv() then require(script.Parent.Parent.Parent.Parent:WaitForChild("package")) else require(script.Parent.Parent.Parent:WaitForChild("package")))
local ConstantsScope = createScope()
local PluginDisplayIcon = "rbxassetid://134897990664604"
local PluginDisplayIconDark = "rbxassetid://106856596627232"
local function GetDynamicPluginDisplayIcon()
	if GetIsNonPluginEnv() == true then
		return PluginDisplayIcon
	end
	return if (settings().Studio).Theme.Name == "Dark" then PluginDisplayIcon else PluginDisplayIconDark
end
local Dynamic_PluginDisplayIcon, setDynamic_PluginDisplayIcon = createState(GetDynamicPluginDisplayIcon())
if GetIsNonPluginEnv() ~= true then
	local ThemeChangedListener = settings().Studio.ThemeChanged:Connect(function()
		setDynamic_PluginDisplayIcon(GetDynamicPluginDisplayIcon())
	end)
	ConstantsScope.Servant:Keep(ThemeChangedListener)
end
local PluginDisplayName = "Runtime UI Select"
local Constants = {
	PluginDisplayName = PluginDisplayName,
	PluginDisplayIcon = PluginDisplayIcon,
	PluginDisplayIconDark = PluginDisplayIconDark,
	Dynamic_PluginDisplayIcon = Dynamic_PluginDisplayIcon,
	PluginAcroName = "Rutus",
	PluginVersion = PackageJSON.version,
	PluginWidgetIdentifierPrefix = "runtime-ui-select",
	PluginSharedSettingsKey = "PluginSharedSettings",
	PluginSharedSettingTokenListener = `{PluginDisplayName}-PluginSharedSettingTokenListener`,
	MainWidgetToolTipCollectionId = "MainWidgetToolTipCollectionId",
	ScreenGuiDisplayOrderLimit = 2147483647,
}
ConstantsScope.Close()
return {
	Constants = Constants,
}
