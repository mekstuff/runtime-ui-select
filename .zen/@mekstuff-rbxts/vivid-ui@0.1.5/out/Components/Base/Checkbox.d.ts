import Vivid from "@mekstuff-rbxts/vivid";
export type CheckboxProps = Vivid.FC.InstanceProperties<TextButton> & {
    icon?: string;
    toggled: boolean;
    disabled?: boolean;
    props?: Partial<{
        UICorner: Vivid.FC.InstanceProperties<UICorner>;
        UIStroke: Vivid.FC.InstanceProperties<UIStroke>;
        ImageLabel: Vivid.FC.InstanceProperties<ImageLabel>;
        UIAspectRatioConstraint: Vivid.FC.InstanceProperties<UIAspectRatioConstraint>;
    }>;
};
export declare function Checkbox(props: CheckboxProps): Instance;
