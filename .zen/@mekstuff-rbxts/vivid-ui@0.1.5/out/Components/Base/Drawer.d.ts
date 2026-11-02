import Vivid from "@mekstuff-rbxts/vivid";
export declare function Drawer(props: {
    onDismiss?: Callback;
    opened?: boolean;
    scale?: number;
    verticalAlignment?: Enum.VerticalAlignment;
    horizontalAlignment?: Enum.HorizontalAlignment;
    children?: unknown;
    props?: Partial<{
        Backdrop: Vivid.FC.InstanceProperties<TextButton>;
        Container: Vivid.FC.InstanceProperties<TextButton>;
        UICorner: Vivid.FC.InstanceProperties<UICorner>;
        ZIndexLayer: Vivid.FC.InstanceProperties<Frame>;
    }>;
}): Instance;
