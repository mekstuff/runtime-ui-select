import Vivid from "@mekstuff-rbxts/vivid";
import { SpinnerProps } from "./Spinner";
import { LabelProps } from "./Label";
export type ButtonProps = Vivid.FC.InstancePropertiesWithChildren<TextButton> & {
    props?: Partial<{
        UICorner: Vivid.FC.InstanceProperties<UICorner>;
        UIStroke: Vivid.FC.InstanceProperties<UIStroke>;
        UIPadding: Vivid.FC.InstanceProperties<UIPadding>;
        UIListLayout: Vivid.FC.InstanceProperties<UIListLayout>;
        IconImage: Vivid.FC.InstanceProperties<ImageLabel>;
        TextLabel: LabelProps;
        SpinnerContainer: Vivid.FC.InstanceProperties<Frame>;
        Spinner: SpinnerProps;
    }>;
    strokeColor?: Color3;
    strokeThickness?: number;
    roundness?: number | UDim;
    /**
     * number | left, top, right, bottom.
     */
    padding?: number | [UDim, UDim, UDim, UDim];
    icon?: string;
    loading?: boolean;
    color?: "default" | "primary" | "danger" | "success";
    variant?: "default" | "outlined" | "ghost" | "link";
    disabled?: boolean;
};
export declare function Button(props: ButtonProps): Instance;
