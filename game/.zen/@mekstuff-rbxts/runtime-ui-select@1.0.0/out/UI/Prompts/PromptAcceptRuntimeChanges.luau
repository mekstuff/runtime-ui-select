-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    15/07/2025 18:58:29
	
]]
local PromptTextOption = TS.import(script, script.Parent, "PromptTextOption").PromptTextOption
local function PromptAcceptRuntimeChanges(onOption)
	return PromptTextOption({
		title = "Save Changes",
		body = "You have made some settings changes during runtime, Do you wish to save them?",
		onOption = onOption,
	})
end
return {
	PromptAcceptRuntimeChanges = PromptAcceptRuntimeChanges,
}
