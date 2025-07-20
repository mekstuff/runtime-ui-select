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
        Backdrop: Vivid.FC.Props<TextButton>;
        Container: Vivid.FC.Props<CanvasGroup>;
        UICorner: Vivid.FC.Props<UICorner>;
        ZIndexLayer: Vivid.FC.Props<Frame>;
    }>;
};
export declare const ModalZIndexLayerDefaultZIndex = 3;
export declare function Modal(props: ModalProps): Instance;
