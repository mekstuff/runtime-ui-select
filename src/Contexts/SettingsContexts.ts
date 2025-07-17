/*
    Typed with ❤️ @mekstuff
    02/07/2025 23:13:32
*/

import { createScope, createState, VividSetState, VividState } from "@mekstuff-rbxts/vivid";

const SettingsContextScope = createScope();

export type Settings = {
	PluginEnabled: boolean;

	HoverDetectionEnabled: boolean;
	ShowDimensionsOnHover: boolean;
	ShowAbsoluteSizeOnHover: boolean;
	ShowAbsolutePositionOnHover: boolean;
	ShowInstanceNameOnHover: boolean;
	MultiHoverDetectionEnabled: boolean;
	UseHoverDetectionActivationKeybind: boolean;

	SelectedDetectionEnabled: boolean;
	ShowDimensionsOnSelected: boolean;
	ShowAbsoluteSizeOnSelected: boolean;
	ShowInstanceNameOnSelected: boolean;
	ShowAbsolutePositionOnSelected: boolean;

	AllowUserRuntimeUISelection: boolean;
	IgnoreTransparentGUIObjects: boolean;
	BlockButtonActivations: boolean;

	DetectRuntimeSettingsChanges: boolean;
	DisableToolTips: boolean;
};
type SettingState<T> = {
	set: VividSetState<T>;
	get: VividState<T>;
};

function CreateSettingState<T>(defaultValue: T): SettingState<T> {
	const [State, setState] = createState(defaultValue);
	return {
		get: State,
		set: setState,
	};
}

export const DefaultSettingsContext: { [k in keyof Settings]: Settings[k] } = {
	PluginEnabled: true,

	HoverDetectionEnabled: true,
	ShowDimensionsOnHover: true,
	ShowAbsoluteSizeOnHover: true,
	ShowAbsolutePositionOnHover: true,
	ShowInstanceNameOnHover: true,
	MultiHoverDetectionEnabled: false,
	UseHoverDetectionActivationKeybind: false,

	SelectedDetectionEnabled: false,
	ShowDimensionsOnSelected: false,
	ShowAbsoluteSizeOnSelected: false,
	ShowInstanceNameOnSelected: false,
	ShowAbsolutePositionOnSelected: false,

	AllowUserRuntimeUISelection: true,
	IgnoreTransparentGUIObjects: true,
	BlockButtonActivations: false,

	DetectRuntimeSettingsChanges: false,
	DisableToolTips: false,
};

export const SettingsContext: { [k in keyof Settings]: SettingState<Settings[k]> } = {} as never;

export function SetSettingsContextDefault() {
	for (const [SettingKey, SettingValue] of pairs(DefaultSettingsContext)) {
		SettingsContext[SettingKey] = SettingsContext[SettingKey] ?? CreateSettingState(SettingValue);
		SettingsContext[SettingKey].set(SettingValue);
	}
}
SetSettingsContextDefault();

SettingsContextScope.Close();
