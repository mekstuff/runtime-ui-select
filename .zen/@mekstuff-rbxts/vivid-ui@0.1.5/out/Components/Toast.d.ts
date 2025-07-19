import Vivid from "@mekstuff-rbxts/vivid";
import { ButtonProps, LabelProps } from "./Base";
import { DismissToastProvider } from "./ToastsList";
export type ToastProps = {
    Text?: string;
    /**
     * Cannot be dynamic/reactive.
     */
    id?: string;
    color?: "info" | "danger" | "warning";
    buttonHidden?: boolean;
    buttonClicked?: (Id?: string) => void;
    toastClicked?: (Id?: string) => void;
    icon?: string;
    viewDisplay?: "dynamic" | "viewport" | "widget" | "mirror";
    roundness?: UDim;
    props?: Partial<{
        Icon: Vivid.FC.Props<ImageLabel>;
        Label: LabelProps;
        Button: ButtonProps;
    }>;
    children?: unknown;
    /**
     * Only works for ToastsListProviders.
     */
    dismissable?: boolean;
    /**
     * Only works for ToastsListProviders.
     */
    dismissToastListProvider?: DismissToastProvider;
    /**
     * Only works for ToastsListProviders.
     */
    lifetime?: number | false;
};
export declare function Toast(props: ToastProps): Instance;
