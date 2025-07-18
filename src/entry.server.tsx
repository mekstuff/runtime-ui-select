/*
	Typed with ❤️ @mekstuff
	02/07/2025 22:12:38
*/

import { Theme } from "@mekstuff-rbxts/vivid-ui";
Theme;

import Vivid, { clearScopes, createScope } from "@mekstuff-rbxts/vivid";
import { setPluginContexts } from "Contexts/PluginContexts";
import { GetIsRunningSession, GetIsRunningSessionServer } from "Core/Functions/GetUsageContext";

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

	return (
		<>
			<HoverDimensionBoxes />
			<SelectedDimensionBoxes />
			{/* <Toasts /> */}
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

// const EntryScope = createScope();
EntrySource();
// EntryScope.Close();
