/**
 *
 * @param Callback The callback that will be ran, Provides resolve and reject functions for manually resolving and rejecting.
 * @param MaximumAttempts Maximum attempts before cancelling recursion. Defaults to `5`.
 * @param IncrementalYields Incremental yield on each try. Defaults to `0.5`.
 * @param AutoResolveThread If the Callback runs without any errors, it will resolve with the value it returned. Defaults to `true`.
 * @returns
 */
declare function RecursiveTry<T, Q extends true | false>(Callback: (resolve: Callback, reject: Callback) => T, MaximumAttempts?: number, IncrementalYields?: number, AutoResolveThread?: boolean): LuaTuple<[Q, Q extends true ? T : string]>;
export { RecursiveTry };
export default RecursiveTry;
