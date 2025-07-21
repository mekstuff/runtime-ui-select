/*
    Typed with ❤️ @mekstuff
    02/07/2025 23:13:32
*/

import { createScope, createState, VividSetState, VividState } from "@mekstuff-rbxts/vivid";

const SettingsContextScope = createScope();

export type Settings = {
	PluginEnabled: boolean;

	HoverDetectionEnabled: boolean;
	HoverDetectionAccuracy: number;
	ShowDimensionsOnHover: boolean;
	ShowAbsoluteSizeOnHover: boolean;
	ShowAbsolutePositionOnHover: boolean;
	ShowInstanceNameOnHover: boolean;
	ShowBorderBoxesOnHover: boolean;
	CalculateBorderBoxRelativeToViewport: boolean;
	ShowLeftBorderBox: boolean;
	ShowTopBorderBox: boolean;
	ShowRightBorderBox: boolean;
	ShowBottomBorderBox: boolean;
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
	RightClickForContextMenu: boolean;
	DisableToolTips: boolean;
};
export type SettingState<T> = {
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
	HoverDetectionAccuracy: 0.1,
	MultiHoverDetectionEnabled: false,
	ShowDimensionsOnHover: true,
	ShowAbsoluteSizeOnHover: true,
	ShowAbsolutePositionOnHover: true,
	ShowInstanceNameOnHover: true,
	ShowBorderBoxesOnHover: true,
	CalculateBorderBoxRelativeToViewport: true,
	ShowLeftBorderBox: true,
	ShowTopBorderBox: true,
	ShowRightBorderBox: true,
	ShowBottomBorderBox: true,
	UseHoverDetectionActivationKeybind: true,

	SelectedDetectionEnabled: false,
	ShowDimensionsOnSelected: false,
	ShowAbsoluteSizeOnSelected: false,
	ShowInstanceNameOnSelected: false,
	ShowAbsolutePositionOnSelected: false,

	AllowUserRuntimeUISelection: true,
	IgnoreTransparentGUIObjects: true,
	BlockButtonActivations: true,

	DetectRuntimeSettingsChanges: false,
	RightClickForContextMenu: true,
	DisableToolTips: false,
};

export const SettingsContext: { [k in keyof Settings]: SettingState<Settings[k]> } = {} as never;

export function SetSettingsContextDefault() {
	for (const [SettingKey, SettingValue] of pairs(DefaultSettingsContext)) {
		SettingsContext[SettingKey] = (SettingsContext[SettingKey] ?? CreateSettingState(SettingValue)) as never;
		(SettingsContext[SettingKey] as SettingState<unknown>).set(SettingValue);
	}
}
SetSettingsContextDefault();

SettingsContextScope.Close();
