-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.include.RuntimeLib)
--[[
	
		Typed with ❤️ @mekstuff
		02/07/2025 22:12:38
	
]]
local _vivid = TS.import(script, script.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out")
local Vivid = _vivid.default
local clearScopes = _vivid.clearScopes
local setPluginContexts = TS.import(script, script.Parent, "Contexts", "PluginContexts").setPluginContexts
local _GetUsageContext = TS.import(script, script.Parent, "Core", "Functions", "GetUsageContext")
local GetIsRunningSession = _GetUsageContext.GetIsRunningSession
local GetIsRunningSessionServer = _GetUsageContext.GetIsRunningSessionServer
local Toasts = TS.import(script, script.Parent, "UI", "Screens", "Toasts").Toasts
-- Setting plugin context
setPluginContexts({
	plugin = plugin,
})
local function SharedRoot()
	local SettingsModuleController = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent, "Core", "Functions", "SettingsModuleController"))
	end):expect()
	SettingsModuleController.LoadSettingsModule()
	SettingsModuleController.InitSettingsListener()
	plugin.Unloading:Connect(function()
		SettingsModuleController.SaveSettingsModule()
		clearScopes()
	end)
	local Toolbar = plugin:CreateToolbar("Rutus")
	local SettingsWidget = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent, "UI", "Widgets", "SettingsWidget"))
	end):expect().SettingsWidget
	return Vivid.createElement(Vivid.createFragment, nil, Vivid.createElement(SettingsWidget, {
		Toolbar = Toolbar,
	}))
end
local function PluginRoot()
	return Vivid.createElement(Vivid.createFragment)
end
local function RuntimeRoot()
	TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent, "Core", "Runtime", "RuntimeUISelection"))
	end):expect()
	TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent, "Core", "Runtime", "RuntimeContextMenu"))
	end):expect()
	local HoverDimensionBoxes = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent, "UI", "Screens", "HoverDimensionBoxes"))
	end):expect().HoverDimensionBoxes
	local SelectedDimensionBoxes = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent, "UI", "Screens", "SelectedDimensionBoxes"))
	end):expect().SelectedDimensionBoxes
	local BorderDistanceBoxes = TS.Promise.new(function(resolve)
		resolve(TS.import(script, script.Parent, "UI", "Screens", "BorderDistanceBoxes"))
	end):expect().BorderDistanceBoxes
	return Vivid.createElement(Vivid.createFragment, nil, Vivid.createElement(HoverDimensionBoxes), Vivid.createElement(SelectedDimensionBoxes), Vivid.createElement(BorderDistanceBoxes), Vivid.createElement(Toasts))
end
local function EntrySource()
	if GetIsRunningSessionServer() == true then
		return nil
	end
	-- Shared
	Vivid.createElement(SharedRoot)
	if GetIsRunningSession() == true then
		-- Studio Runtime (Client)
		Vivid.createElement(RuntimeRoot)
		return nil
	end
	-- Studio "Plugin" Only
	Vivid.createElement(PluginRoot)
end
-- const EntryScope = createScope();
EntrySource()
-- EntryScope.Close();
