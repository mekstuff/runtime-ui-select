import { ModalProps } from "./Base/index";
export type PopoverProps = {
    opened?: boolean;
    scale?: number;
    backdropTransparency?: number;
    offset?: UDim2;
    props?: Partial<{
        Modal: ModalProps;
    }>;
    hideArrow?: boolean;
    arrowColor?: Color3;
    verticalAlignment?: Enum.VerticalAlignment;
    horizontalAlignment?: Enum.HorizontalAlignment;
    adornee?: GuiObject;
    children?: unknown;
};
export declare function Popover(props: PopoverProps): Instance;
