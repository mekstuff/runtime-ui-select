import { VividState } from "./createState";
export type _external_ref<T, NonNullable extends boolean = false> = NonNullable extends true ? VividState<T> : VividState<T | undefined>;
export type _internal_ref = {
    _set: (value: unknown) => void;
    _is_vivid_ref: boolean;
} & (() => unknown);
export type RefObject<T, NonNullable extends boolean = false> = _external_ref<T, NonNullable>;
export declare function IsVividRefObject(input: unknown): input is _internal_ref;
/**
 * NonNullable generic should only be used if you're certain you'll only call the Ref within a safe lifecycle. e.g.: onMount.
 */
export declare function createRef<T = Instance, NonNullable extends boolean = false>(): _external_ref<T, NonNullable>;
