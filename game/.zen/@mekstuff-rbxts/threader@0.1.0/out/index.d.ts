/**
 * For controlling a thread outside of it's "scope".
 *
 * Use the custom `typeIs` function from `mekstuff-rbxts/core` to check if object is a threader.
 * You should not use this as a stand alone library, You should install `mekstuff-rbxts/core` to access threader.
 */
export declare class threader {
    private readonly initiator;
    active: boolean;
    private noAutoClose?;
    /**
     * Track closed state
     */
    private _closed;
    /**
     * Returns `true` if the threader is closed, `false` if not.
     */
    isClosed(): boolean;
    /**
     * Closes the `threader`, setting `active` after closing will have no effect.
     *
     * Threaders are automatically closed after executing, use `tryClose` for attempting to `close` without any errors.
     */
    close(): void;
    /**
     * Closes the treader if it is not already closed, returns `true` if closed, `false` otherwise.
     */
    tryClose(): boolean;
    /**
     * @param active The active state of the threader. while active is set to `true`, the coroutine will begin executing,
     * setting to `false` will end the coroutine.
     * @param initiator The function the will be running on the `threader`
     * @param [active=false] State of the `threader`, if `false`, the initiator function will stop executing if it were.
     * if `true the initiator function will begin executing
     * @param noAutoClose By default, threaders will automatically close after the initiator function is finished executing, use
     * `noAutoClose` to override this behaviour.
     */
    constructor(initiator: (t: threader) => void, active?: boolean, noAutoClose?: boolean | undefined);
}
/**
 * Checks if object is a threader
 */
export declare function isThreader(object: unknown): object is threader;
export declare function setThreaderDebugLogsEnabled(State: boolean): void;
