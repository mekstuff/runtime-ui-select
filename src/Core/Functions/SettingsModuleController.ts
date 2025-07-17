/*
    Typed with ❤️ @mekstuff
    07/07/2025 12:45:44
*/

import { createCleanup, createEffect, use } from "@mekstuff-rbxts/vivid";
import { Settings, SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { GetPlugin } from "Core/Functions/GetPlugin";
import { GetIsRunningSession } from "Core/Functions/GetUsageContext";
import { GetPluginSharedSettingToken, UpdatePluginSharedToken } from "./GetPluginSharedSettingToken";
import { PromptAcceptRuntimeChanges } from "UI/Prompts/PromptAcceptRuntimeChanges";

export type SettingsModuleData = { [k in keyof Settings]?: Settings[k] };

export function ClearSettingsModule() {
	const plugin = GetPlugin();
	plugin.SetSetting(Constants.PluginSharedSettingsKey, undefined);
}

export function SaveSettingsModule() {
	const plugin = GetPlugin();
	const SettingsData: SettingsModuleData = {};
	for (const [Key, Value] of pairs(SettingsContext)) {
		SettingsData[Key] = use(() => Value.get());
	}
	plugin.SetSetting(Constants.PluginSharedSettingsKey, SettingsData);
}

export function LoadSettingsModule() {
	const plugin = GetPlugin();
	const Settings = plugin.GetSetting(Constants.PluginSharedSettingsKey) as SettingsModuleData | undefined;
	if (Settings === undefined) {
		return;
	}
	const RunToggleLoop = () => {
		for (const [key, value] of pairs(Settings)) {
			const SettingExists = SettingsContext[key];
			if (SettingExists === undefined) {
				continue;
			}
			SettingExists.set(value);
		}
	};
	RunToggleLoop();
	RunToggleLoop(); // x2 for settings that are dependent on other settings :/
}

export function InitSettingsListener() {
	let DidDependencyLoop = false;
	let DidUpdateSessionSaveScript = false;

	if (GetIsRunningSession() === false) {
		createEffect(() => {
			if (SettingsContext.DetectRuntimeSettingsChanges.get() === false) {
				return;
			}
			const PluginSharedSettingToken = GetPluginSharedSettingToken();
			const Listener = PluginSharedSettingToken.GetPropertyChangedSignal("Source").Connect(() => {
				PromptAcceptRuntimeChanges((Option) => {
					if (Option === false) {
						SaveSettingsModule();
						return;
					}
					LoadSettingsModule();
				});
			});

			createCleanup(() => {
				Listener.Disconnect();
				PluginSharedSettingToken.Destroy();
			});
		});
	}

	createEffect(() => {
		if (DidDependencyLoop === false) {
			for (const [_, Value] of pairs(SettingsContext)) {
				Value.get();
			}
			DidDependencyLoop = true;
		} else {
			SaveSettingsModule();

			if (DidUpdateSessionSaveScript === false && GetIsRunningSession() === true) {
				if (SettingsContext.DetectRuntimeSettingsChanges.get() === false) {
					return;
				}
				DidUpdateSessionSaveScript = true;
				UpdatePluginSharedToken(true);
			}
		}
	});
}
