export declare const _FragmentIdentifier_ = "__VIVID.FRAGMENT__";
export type _internal_fragment = {
    children: unknown;
    _is_fragment: boolean;
    Destroy: Callback;
    Destroying: RBXScriptSignal;
    _data_fields?: Record<string, unknown>;
    _force_mounted?: boolean;
};
export declare function IsInternalFragment(Target: unknown): Target is _internal_fragment;
export declare function CreateInternalFragment(targetChildren?: unknown): _internal_fragment;
