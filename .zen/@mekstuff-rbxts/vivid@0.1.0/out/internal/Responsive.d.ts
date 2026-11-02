import { State } from "@mekstuff-rbxts/core";
export type ResponsiveGroupName = "sm" | "md" | "lg" | "xl" | "xl2";
export type ResponsiveObjectInternal<T> = {
    _is_responsive_object: boolean;
    _group_state: State<ResponsiveGroupName>;
    _responsive: Partial<Record<ResponsiveGroupName, T>>;
    _increment_usage_total: Callback;
    _decrement_usage_total: Callback;
};
type ResponsiveBreakpoints = {
    responsive: ResponsiveGroupName;
    breakpoint: number;
}[];
declare const ResponsiveBreakpoints: {
    responsive: ResponsiveGroupName;
    breakpoint: number;
}[];
export declare function IsResponsiveObject<T>(Input: unknown): Input is ResponsiveObjectInternal<T>;
/**
 * Create your own responsive object with custom breakpoints and default container.
 */
export declare function CreateResponsive(config: {
    breakpoints: Partial<ResponsiveBreakpoints>;
    container: GuiObject | Camera;
}): <T>(props: ResponsiveProps<T>) => T;
type ResponsiveProps<T> = {
    sm: T;
    md?: T;
    lg?: T;
    xl?: T;
    xl2?: T;
    container?: GuiObject | Camera;
    /**
     * @hidden
     * @private
     *
     * Use `CreateResponsive` instead.
     */
    breakpoints?: ResponsiveBreakpoints;
};
/**
 * Use within a createEffect that is used for a `createElement` property for a responsive values.
 */
export declare function Responsive<T>(props: ResponsiveProps<T>): T;
export {};
