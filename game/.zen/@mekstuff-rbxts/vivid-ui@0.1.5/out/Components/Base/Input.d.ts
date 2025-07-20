import Vivid from "@mekstuff-rbxts/vivid";
export type InputProps = Vivid.FC.Props<TextBox> & {
    strokeThickness?: number;
    roundness?: number | UDim;
    /**
     * number | left, top, right, bottom.
     */
    padding?: number | [UDim, UDim, UDim, UDim];
    color?: "primary" | "border" | "default";
    props?: Partial<{
        UIPadding: Vivid.FC.Props<UIPadding>;
        UIStroke: Vivid.FC.Props<UIStroke>;
        UICorner: Vivid.FC.Props<UICorner>;
    }>;
};
export declare function Input(props: InputProps): Instance;
