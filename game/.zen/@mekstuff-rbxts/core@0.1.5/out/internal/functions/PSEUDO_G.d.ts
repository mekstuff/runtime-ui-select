export declare const PSEUDO_G: UnknownArray & {
    set: (key: unknown, value: unknown) => void;
    get: <T>(key: unknown, timeout?: number) => Promise<T>;
};
