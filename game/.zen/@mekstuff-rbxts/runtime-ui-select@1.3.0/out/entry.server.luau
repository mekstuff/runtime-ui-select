-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
		Typed with ❤️ @mekstuff
		02/07/2025 22:12:38
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local clearScopes = _vivid.clearScopes
local setPluginContexts = TS.import(script, script.Parent, "Contexts", "PluginContexts").setPluginContexts
local Constants = TS.import(script, script.Parent, "Core", "Constants", "Constants").Constants
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
	local Toolbar = plugin:CreateToolbar(`{Constants.PluginAcroName} {Constants.PluginVersion}`)
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
EntrySource()
--[=[
	*
	 * Basic Free Command Line Version:
	--[[
		Simple version of Rutus, Execute in command line then click on any GUI elements on screen
		to select it within the explorer!
		
		Get Rutus: https://devforum.roblox.com/ 
	]]
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local SelectionService = game:GetService("Selection")
	local UserInputService = game:GetService("UserInputService")
	
	local IsClient = RunService:IsClient()
	local IsRunning = RunService:IsRunning()
	
	if(IsClient == false)then
		warn("Rutus CMDL - Command should only be executed on the client.")
		return
	end
	
	if(IsRunning == false)then
		warn("Rutus CMDL - Command should only be executed while the experience is running.")
		return
	end
	
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui
		
	local ActiveRuntimeUISelectConnection: RBXScriptConnection
	
	local function DisableRuntimeUISelect()
		if(ActiveRuntimeUISelectConnection)then
			ActiveRuntimeUISelectConnection:Disconnect()
			ActiveRuntimeUISelectConnection = nil
		end
	end
	
	local function EnableRuntimeUISelect()
		DisableRuntimeUISelect()
		print("Rutus CMDL - Listening for GUI Selection...")
		ActiveRuntimeUISelectConnection = UserInputService.InputBegan:Connect(function(Input)
			if(Input.UserInputType ~= Enum.UserInputType.MouseButton1)then
				return
			end
			DisableRuntimeUISelect()
			local GuiElementsAtPosition = PlayerGui:GetGuiObjectsAtPosition(Input.Position.X, Input.Position.Y)
			local TargetElement = GuiElementsAtPosition[1]
			if(TargetElement == nil)then
				print("Rutus CMDL - There were no visible GUI's where you pressed!")
				return
			end
			print(`Rutus CMDL - Selected {TargetElement}. Other Elements:`)
			for index, element in GuiElementsAtPosition do
				if(index == 1)then
					continue
				end
				print("\t", element)
			end
		end)
	end
	
	EnableRuntimeUISelect()
	 
]=]
