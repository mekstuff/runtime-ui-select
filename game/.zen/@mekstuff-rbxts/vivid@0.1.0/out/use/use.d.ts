/**
 * Useful reactive values without making them become a dependency/causing reruns of the function. The function will return the value of the item returned by your function
 * at the given time.
 */
export declare function use<T>(input: () => T): T;
