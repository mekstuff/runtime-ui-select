import { Pseudo } from "../Pseudo/Pseudo";
export declare class Cache<K extends unknown[], V> extends Pseudo {
    private FetchFunction;
    private _cached;
    /**
     * KeyID is a unique identifier for parameters provided.
     */
    private GetKeyID;
    private _getIsCachedDataExpired;
    /**
     * Will automatically clear expired data after the set interval.
     *
     * Set to `-1` to disable.
     */
    AutoClearExpiredCacheInterval: number;
    /**
     * How long each cached item will exist before it is considered expired.
     */
    CacheLifetime: number;
    /**
     * Returns the cached value.
     */
    GetCached(KeyId: string): V | undefined;
    /**
     * Can be Asynchronous if you `FetchFunction` is.
     *
     * @async
     */
    Get(...args: K): V;
    Set(KeyId: string, Value: V, Lifetime?: number): void;
    Delete(KeyId: string): boolean;
    Clear(): void;
    ClearExpired(): void;
    constructor(FetchFunction: (...args: K) => V);
}
