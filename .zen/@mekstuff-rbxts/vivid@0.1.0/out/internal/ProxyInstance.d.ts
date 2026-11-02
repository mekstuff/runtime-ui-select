export declare const _FragmentIdentifier_: "__VIVID.FRAGMENT__";
export type _internal_proxyInstance = {
    _getInstance: () => Instance;
    _is_proxyInstance: boolean;
};
export declare function IsInternalProxyInstance(Target: unknown): Target is _internal_proxyInstance;
export declare function CreateProxyInstance(CreatedInstance: Instance, OnIndex: (t: unknown, k: unknown) => unknown): _internal_proxyInstance;
