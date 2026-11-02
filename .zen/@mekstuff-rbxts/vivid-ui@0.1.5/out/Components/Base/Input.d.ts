import Vivid from "@mekstuff-rbxts/vivid";
export type InputProps = Vivid.FC.InstancePropertiesWithChildren<TextBox> & {
    strokeThickness?: number;
    roundness?: number | UDim;
    /**
     * number | left, top, right, bottom.
     */
    padding?: number | [UDim, UDim, UDim, UDim];
    color?: "primary" | "border" | "default";
    props?: Partial<{
        UIPadding: Vivid.FC.InstanceProperties<UIPadding>;
        UIStroke: Vivid.FC.InstanceProperties<UIStroke>;
        UICorner: Vivid.FC.InstanceProperties<UICorner>;
    }>;
};
export declare function Input(props: InputProps): Instance;
