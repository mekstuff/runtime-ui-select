import { Settings } from "../../Contexts/SettingsContexts";
export type SettingsModuleData = {
    [k in keyof Settings]?: Settings[k];
};
export declare function ClearSettingsModule(): void;
export declare function SaveSettingsModule(): void;
export declare function LoadSettingsModule(): void;
export declare function InitSettingsListener(): void;
