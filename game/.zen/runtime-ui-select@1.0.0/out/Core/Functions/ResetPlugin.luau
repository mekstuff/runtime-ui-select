-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    16/07/2025 22:38:36
	
]]
local SetSettingsContextDefault = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SetSettingsContextDefault
local PromptTextOption = TS.import(script, script.Parent.Parent.Parent, "UI", "Prompts", "PromptTextOption").PromptTextOption
local ClearSettingsModule = TS.import(script, script.Parent, "SettingsModuleController").ClearSettingsModule
local function ResetPluginToDefault()
	PromptTextOption({
		title = "Reset",
		body = "Are you sure you want to reset the current settings to the default?",
		onOption = function(option)
			if option == false then
				return nil
			end
			SetSettingsContextDefault()
			SetSettingsContextDefault()
			ClearSettingsModule()
		end,
	})
end
return {
	ResetPluginToDefault = ResetPluginToDefault,
}
