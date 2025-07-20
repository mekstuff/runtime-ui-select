import Vivid from "@mekstuff-rbxts/vivid";
import { SpinnerProps } from "./Spinner";
import { LabelProps } from "./Label";
export type ButtonProps = Vivid.FC.Props<TextButton> & {
    props?: Partial<{
        UICorner: Vivid.FC.Props<UICorner>;
        UIStroke: Vivid.FC.Props<UIStroke>;
        UIPadding: Vivid.FC.Props<UIPadding>;
        UIListLayout: Vivid.FC.Props<UIListLayout>;
        IconImage: Vivid.FC.Props<ImageLabel>;
        TextLabel: LabelProps;
        SpinnerContainer: Vivid.FC.Props<Frame>;
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
