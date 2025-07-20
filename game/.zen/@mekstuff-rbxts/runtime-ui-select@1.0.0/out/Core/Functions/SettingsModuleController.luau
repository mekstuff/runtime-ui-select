-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/07/2025 12:45:44
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local use = _vivid.use
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local Constants = TS.import(script, script.Parent.Parent, "Constants", "Constants").Constants
local GetPlugin = TS.import(script, script.Parent, "GetPlugin").GetPlugin
local _GetUsageContext = TS.import(script, script.Parent, "GetUsageContext")
local GetIsNonPluginEnv = _GetUsageContext.GetIsNonPluginEnv
local GetIsRunningSession = _GetUsageContext.GetIsRunningSession
local _GetPluginSharedSettingToken = TS.import(script, script.Parent, "GetPluginSharedSettingToken")
local GetPluginSharedSettingToken = _GetPluginSharedSettingToken.GetPluginSharedSettingToken
local UpdatePluginSharedToken = _GetPluginSharedSettingToken.UpdatePluginSharedToken
local PromptAcceptRuntimeChanges = TS.import(script, script.Parent.Parent.Parent, "UI", "Prompts", "PromptAcceptRuntimeChanges").PromptAcceptRuntimeChanges
local function ClearSettingsModule()
	if GetIsNonPluginEnv() then
		return nil
	end
	local plugin = GetPlugin()
	plugin:SetSetting(Constants.PluginSharedSettingsKey, nil)
end
local function SaveSettingsModule()
	if GetIsNonPluginEnv() then
		return nil
	end
	local plugin = GetPlugin()
	local SettingsData = {}
	for Key, Value in pairs(SettingsContext) do
		SettingsData[Key] = use(function()
			return Value.get()
		end)
	end
	plugin:SetSetting(Constants.PluginSharedSettingsKey, SettingsData)
end
local function LoadSettingsModule()
	if GetIsNonPluginEnv() then
		return nil
	end
	local plugin = GetPlugin()
	local Settings = plugin:GetSetting(Constants.PluginSharedSettingsKey)
	if Settings == nil then
		return nil
	end
	local RunToggleLoop = function()
		for key, value in pairs(Settings) do
			local SettingExists = SettingsContext[key]
			if SettingExists == nil then
				continue
			end
			SettingExists.set(value)
		end
	end
	RunToggleLoop()
	RunToggleLoop()
end
local function InitSettingsListener()
	if GetIsNonPluginEnv() then
		return nil
	end
	local DidDependencyLoop = false
	local DidUpdateSessionSaveScript = false
	if GetIsRunningSession() == false then
		createEffect(function()
			if SettingsContext.DetectRuntimeSettingsChanges.get() == false then
				return nil
			end
			local PluginSharedSettingToken = GetPluginSharedSettingToken()
			local Listener = PluginSharedSettingToken:GetPropertyChangedSignal("Source"):Connect(function()
				PromptAcceptRuntimeChanges(function(Option)
					if Option == false then
						SaveSettingsModule()
						return nil
					end
					LoadSettingsModule()
				end)
			end)
			createCleanup(function()
				Listener:Disconnect()
				PluginSharedSettingToken:Destroy()
			end)
		end)
	end
	createEffect(function()
		if DidDependencyLoop == false then
			for _, Value in pairs(SettingsContext) do
				Value.get()
			end
			DidDependencyLoop = true
		else
			SaveSettingsModule()
			if DidUpdateSessionSaveScript == false and GetIsRunningSession() == true then
				if SettingsContext.DetectRuntimeSettingsChanges.get() == false then
					return nil
				end
				DidUpdateSessionSaveScript = true
				UpdatePluginSharedToken(true)
			end
		end
	end)
end
return {
	ClearSettingsModule = ClearSettingsModule,
	SaveSettingsModule = SaveSettingsModule,
	LoadSettingsModule = LoadSettingsModule,
	InitSettingsListener = InitSettingsListener,
}
