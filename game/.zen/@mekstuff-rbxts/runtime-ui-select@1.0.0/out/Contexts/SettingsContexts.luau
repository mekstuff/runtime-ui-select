-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 23:13:32
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local createScope = _vivid.createScope
local createState = _vivid.createState
local SettingsContextScope = createScope()
local function CreateSettingState(defaultValue)
	local State, setState = createState(defaultValue)
	return {
		get = State,
		set = setState,
	}
end
local DefaultSettingsContext = {
	PluginEnabled = true,
	HoverDetectionEnabled = true,
	HoverDetectionAccuracy = 0.1,
	MultiHoverDetectionEnabled = false,
	ShowDimensionsOnHover = true,
	ShowAbsoluteSizeOnHover = true,
	ShowAbsolutePositionOnHover = true,
	ShowInstanceNameOnHover = true,
	ShowBorderBoxesOnHover = true,
	CalculateBorderBoxRelativeToViewport = true,
	ShowLeftBorderBox = true,
	ShowTopBorderBox = true,
	ShowRightBorderBox = true,
	ShowBottomBorderBox = true,
	UseHoverDetectionActivationKeybind = true,
	SelectedDetectionEnabled = false,
	ShowDimensionsOnSelected = false,
	ShowAbsoluteSizeOnSelected = false,
	ShowInstanceNameOnSelected = false,
	ShowAbsolutePositionOnSelected = false,
	AllowUserRuntimeUISelection = true,
	IgnoreTransparentGUIObjects = true,
	BlockButtonActivations = true,
	DetectRuntimeSettingsChanges = false,
	RightClickForContextMenu = true,
	DisableToolTips = false,
}
local SettingsContext = {}
local function SetSettingsContextDefault()
	for SettingKey, SettingValue in pairs(DefaultSettingsContext) do
		SettingsContext[SettingKey] = (SettingsContext[SettingKey] or CreateSettingState(SettingValue));
		(SettingsContext[SettingKey]).set(SettingValue)
	end
end
SetSettingsContextDefault()
SettingsContextScope.Close()
return {
	SetSettingsContextDefault = SetSettingsContextDefault,
	DefaultSettingsContext = DefaultSettingsContext,
	SettingsContext = SettingsContext,
}
