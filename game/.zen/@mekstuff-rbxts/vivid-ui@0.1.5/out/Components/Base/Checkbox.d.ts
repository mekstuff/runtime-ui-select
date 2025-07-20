import Vivid from "@mekstuff-rbxts/vivid";
export type CheckboxProps = Vivid.FC.Props<TextButton> & {
    icon?: string;
    toggled: boolean;
    disabled?: boolean;
    props?: Partial<{
        UICorner: Vivid.FC.Props<UICorner>;
        UIStroke: Vivid.FC.Props<UIStroke>;
        ImageLabel: Vivid.FC.Props<ImageLabel>;
        UIAspectRatioConstraint: Vivid.FC.Props<UIAspectRatioConstraint>;
    }>;
};
export declare function Checkbox(props: CheckboxProps): Instance;
