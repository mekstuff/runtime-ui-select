import Vivid from "@mekstuff-rbxts/vivid";
export declare function ToggleSwitch(props: Vivid.FC.Props<Vivid.FC.InstanceProps<TextButton>> & {
    setToggled?: Vivid.StateSetter<boolean>;
    onToggle?: Callback;
    toggled: boolean;
    disabled?: boolean;
    props?: Partial<{
        UICorner: Vivid.FC.Props<UICorner>;
        UIPadding: Vivid.FC.Props<UIPadding>;
        ToggleFrame: Vivid.FC.Props<Frame>;
        ToggleFrameUICorner: Vivid.FC.Props<UICorner>;
        ToggleFrameUIAspectRatioConstraint: Vivid.FC.Props<UIAspectRatioConstraint>;
    }>;
}): Instance;
