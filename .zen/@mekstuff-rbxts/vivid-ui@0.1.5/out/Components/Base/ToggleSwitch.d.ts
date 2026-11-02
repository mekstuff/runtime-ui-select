import Vivid from "@mekstuff-rbxts/vivid";
export declare function ToggleSwitch(props: Vivid.FC.InstanceProperties<TextButton> & {
    setToggled?: Vivid.StateSetter<boolean>;
    onToggle?: Callback;
    toggled: boolean;
    disabled?: boolean;
    props?: Partial<{
        UICorner: Vivid.FC.InstanceProperties<UICorner>;
        UIPadding: Vivid.FC.InstanceProperties<UIPadding>;
        ToggleFrame: Vivid.FC.InstanceProperties<Frame>;
        ToggleFrameUICorner: Vivid.FC.InstanceProperties<UICorner>;
        ToggleFrameUIAspectRatioConstraint: Vivid.FC.InstanceProperties<UIAspectRatioConstraint>;
    }>;
}): Instance;
