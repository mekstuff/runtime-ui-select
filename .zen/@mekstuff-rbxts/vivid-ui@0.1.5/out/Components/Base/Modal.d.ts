import Vivid from "@mekstuff-rbxts/vivid";
export type ModalProps = {
    onDismiss?: Callback;
    opened?: boolean;
    children?: unknown;
    scale?: number;
    openedPosition?: UDim2;
    closedPosition?: UDim2;
    backdropTransparency?: number;
    props?: Partial<{
        Backdrop: Vivid.FC.InstanceProperties<TextButton>;
        Container: Vivid.FC.InstanceProperties<CanvasGroup>;
        UICorner: Vivid.FC.InstanceProperties<UICorner>;
        ZIndexLayer: Vivid.FC.InstanceProperties<Frame>;
    }>;
};
export declare const ModalZIndexLayerDefaultZIndex = 3;
export declare function Modal(props: ModalProps): Instance;
