import Vivid from "@mekstuff-rbxts/vivid";
import { ToastProps } from "./Toast";
type SendToastProvider_Prop = (Toast: ToastProps) => void;
export type SendToastProvider = {
    callback: (Toast: ToastProps) => void;
    provider: SendToastProvider_Prop;
};
/**
 * If `true`, all toasts will be dismissed.
 * If `Toast`, the ID of the toast will be dismissed.
 * If `string`, the ID of the toast will be dismissed.
 */
type DismissToastProvider_Prop = (ToastOrToastIdOrDismissAll: ToastProps | string | true) => void;
export type DismissToastProvider = {
    callback: DismissToastProvider_Prop;
    provider: DismissToastProvider_Prop;
};
export declare function CreateSendToastProvider(): SendToastProvider;
export declare function CreateDismissToastProvider(): DismissToastProvider;
export type ToastsListProviderProps = Omit<ToastsListProps, "toasts"> & {
    sendToastProvider: SendToastProvider;
    dismissToastProvider: DismissToastProvider;
};
/**
 * This allows you to create functions for Sending and Dismissing toasts.
 *
 * @example
 * ```tsx
 * const SendToastProvider = CreateSendToastProvider();
 * const DismissToastProvider = CreateDismissToastProvider();
 *
 * <>
 * 	<ToastsListProvider sendToastProvider={SendToastProvider} dismissToastProvider={DismissToastProvider} />
 * </>
 *
 * export const SendToast = SendToastProvider.callback; // You can call this callback anywhere to send a toast.
 * export const DismissToast = DismissToastProvider.callback; // You can call this callback anywhere to dismiss a toast.
 * ```
 *
 * NOTE: If `buttonHidden` is `undefined` and dismissable is not set to `true` and not `buttonClicked` callback is provided, `buttonHidden` will become `true`
 * NOTE: `lifetime` for Toasts default to `20` if value is `undefined`. setting value to `false` will disable auto dismissal after lifetime period.
 */
export declare function ToastsListProvider(props: ToastsListProviderProps): Instance;
export type ToastsListProps = Vivid.FC.Props<Frame> & {
    toasts: ToastProps[];
    props?: Partial<{
        UIPadding: Vivid.FC.Props<UIPadding>;
        UIListLayout: Vivid.FC.Props<UIListLayout>;
    }>;
};
export declare function ToastsList(props: ToastsListProps): Instance;
export {};
