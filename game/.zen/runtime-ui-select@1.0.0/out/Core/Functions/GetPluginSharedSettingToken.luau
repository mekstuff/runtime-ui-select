-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    15/07/2025 18:07:05
	
]]
local Engine = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "core", "out").Engine
local Constants = TS.import(script, script.Parent.Parent, "Constants", "Constants").Constants
local function GetPluginSharedSettingToken()
	local TargetSource = Engine.FetchReplicatedStorage():FindFirstChild(Constants.PluginSharedSettingTokenListener)
	if TargetSource ~= nil and TargetSource:IsA("ModuleScript") == false then
		TargetSource:Destroy()
		TargetSource = nil
	end
	if TargetSource == nil then
		TargetSource = Instance.new("ModuleScript")
		TargetSource.Name = Constants.PluginSharedSettingTokenListener
		TargetSource.Parent = Engine.FetchReplicatedStorage()
	end
	return TargetSource
end
local function InsertPluginSharedSettingToken()
	return GetPluginSharedSettingToken()
end
local function UpdatePluginSharedToken(OpenDocument)
	local ScriptEditorService = game:GetService("ScriptEditorService")
	TS.Promise.try(function()
		local PluginSharedSettingToken = GetPluginSharedSettingToken()
		if OpenDocument == true then
			local Success, Results = ScriptEditorService:OpenScriptDocumentAsync(PluginSharedSettingToken)
			if Success == false then
				error(`Could not OpenScriptDocumentAsync - {Results}`)
			end
		end
		ScriptEditorService:UpdateSourceAsync(PluginSharedSettingToken, function()
			return `\
--[[\
	* This file was automatically generated and should not be directly edited\
	* This file allows runtime-ui-select to detect settings changes during runtime.\
	* Generated with ❤️ @mekstuff\
]]\
\
return \{\
	stamp = {DateTime.now().UnixTimestamp}\
\};\
`
		end)
		if OpenDocument == true then
			local ScriptDocument = ScriptEditorService:FindScriptDocument(PluginSharedSettingToken)
			if ScriptDocument == nil then
				error(`Could not FindScriptDocument`)
			end
			ScriptDocument:CloseAsync()
		end
	end)
end
return {
	GetPluginSharedSettingToken = GetPluginSharedSettingToken,
	InsertPluginSharedSettingToken = InsertPluginSharedSettingToken,
	UpdatePluginSharedToken = UpdatePluginSharedToken,
}
