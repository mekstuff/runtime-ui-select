import { State } from "@mekstuff-rbxts/core";
export type ResponsiveGroupName = "sm" | "md" | "lg" | "xl" | "xl2";
export type ResponsiveObjectInternal<T> = {
    _is_responsive_object: boolean;
    _group_state: State<ResponsiveGroupName>;
    _responsive: Partial<Record<ResponsiveGroupName, T>>;
    _increment_usage_total: Callback;
    _decrement_usage_total: Callback;
};
export declare function IsResponsiveObject<T>(Input: unknown): Input is ResponsiveObjectInternal<T>;
export declare function Responsive<T>(props: {
    sm: T;
    md?: T;
    lg?: T;
    xl?: T;
    xl2?: T;
    container?: GuiObject | Camera;
}): T;
