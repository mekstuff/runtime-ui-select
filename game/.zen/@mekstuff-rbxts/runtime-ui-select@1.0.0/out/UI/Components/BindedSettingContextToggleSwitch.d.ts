import { SettingsContext } from "../../Contexts/SettingsContexts";
export declare function BindedSettingContextToggleSwitch(props: {
    Text: string;
    TargetSettingContext: keyof typeof SettingsContext;
    Dependencies?: (keyof typeof SettingsContext)[];
    InverseDependencies?: (keyof typeof SettingsContext)[];
    UnavailableFeature?: boolean;
    ToolTip?: string;
}): Instance;
