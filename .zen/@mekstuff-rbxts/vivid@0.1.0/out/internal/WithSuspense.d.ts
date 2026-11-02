export type WithSuspenseDef<T = unknown> = {
    _isWithSuspense: true;
    _exec_promise: Promise<T>;
    _default_value: T;
    _error_value?: T;
};
export declare function IsWithSuspenseDef(Input: unknown): Input is WithSuspenseDef;
/**
 * Use within a createEffect that is used for a `createElement` property. If Callback is a function, it will be wrapped in a Promise.try().
 *
 * ```ts
 * <frame BackgroundTransparency={() => {
 * 	return withSuspense(() => {
 * 		task.wait(2)
 * 		return 1 // BackgroundTransparency will change to `1` from `0.5` after `2` seconds.
 * 	}, 0.5)
 * }}/>
 * ```
 */
export declare function WithSuspense<V>(Callback: (() => V) | Promise<V>, DefaultValue: V, ErrorValue?: V): V;
