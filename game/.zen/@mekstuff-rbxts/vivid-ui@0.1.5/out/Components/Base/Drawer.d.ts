import Vivid from "@mekstuff-rbxts/vivid";
export declare function Drawer(props: {
    onDismiss?: Callback;
    opened?: boolean;
    scale?: number;
    verticalAlignment?: Enum.VerticalAlignment;
    horizontalAlignment?: Enum.HorizontalAlignment;
    children?: unknown;
    props?: Partial<{
        Backdrop: Vivid.FC.Props<TextButton>;
        Container: Vivid.FC.Props<TextButton>;
        UICorner: Vivid.FC.Props<UICorner>;
        ZIndexLayer: Vivid.FC.Props<Frame>;
    }>;
}): Instance;
