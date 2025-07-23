/*
	Typed with ❤️ @mekstuff
	02/07/2025 22:12:38
*/

import Vivid, { clearScopes } from "@mekstuff-rbxts/vivid";
import { setPluginContexts } from "Contexts/PluginContexts";
import { GetIsRunningSession, GetIsRunningSessionServer } from "Core/Functions/GetUsageContext";
import { Toasts } from "UI/Screens/Toasts";

// Setting plugin context
setPluginContexts({
	plugin: plugin,
});

function SharedRoot() {
	const SettingsModuleController = import("Core/Functions/SettingsModuleController").expect();
	SettingsModuleController.LoadSettingsModule();
	SettingsModuleController.InitSettingsListener();
	plugin.Unloading.Connect(() => {
		SettingsModuleController.SaveSettingsModule();
		clearScopes();
	});

	const Toolbar = plugin.CreateToolbar("Rutus");

	const SettingsWidget = import("UI/Widgets/SettingsWidget").expect().SettingsWidget;

	return (
		<>
			<SettingsWidget Toolbar={Toolbar} />
		</>
	);
}

function PluginRoot() {
	return <></>;
}

function RuntimeRoot() {
	import("Core/Runtime/RuntimeUISelection").expect();
	import("Core/Runtime/RuntimeContextMenu").expect();
	const HoverDimensionBoxes = import("UI/Screens/HoverDimensionBoxes").expect().HoverDimensionBoxes;
	const SelectedDimensionBoxes = import("UI/Screens/SelectedDimensionBoxes").expect().SelectedDimensionBoxes;
	const BorderDistanceBoxes = import("UI/Screens/BorderDistanceBoxes").expect().BorderDistanceBoxes;

	return (
		<>
			<HoverDimensionBoxes />
			<SelectedDimensionBoxes />
			<BorderDistanceBoxes />
			<Toasts />
		</>
	);
}

function EntrySource() {
	if (GetIsRunningSessionServer() === true) {
		return;
	}

	// Shared
	<SharedRoot />;

	if (GetIsRunningSession() === true) {
		// Studio Runtime (Client)
		<RuntimeRoot />;
		return;
	}

	// Studio "Plugin" Only
	<PluginRoot />;
}

EntrySource();

/**
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
 */
