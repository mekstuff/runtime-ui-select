import { VividSetState, VividState } from "@mekstuff-rbxts/vivid";
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
export declare const DefaultSettingsContext: {
    [k in keyof Settings]: Settings[k];
};
export declare const SettingsContext: {
    [k in keyof Settings]: SettingState<Settings[k]>;
};
export declare function SetSettingsContextDefault(): void;
