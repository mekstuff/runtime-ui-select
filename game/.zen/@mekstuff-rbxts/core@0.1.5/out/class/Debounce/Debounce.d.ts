import { Pseudo } from "../Pseudo/Pseudo";
type DebounceParams<X extends RBXScriptSignal | Callback> = {
    debouncer: X;
    callback?: Callback;
    time?: number;
    firstArgDebounce?: boolean;
    connectParallel?: X extends RBXScriptSignal ? boolean : never;
    validator?: (isDebounced: boolean, ...args: X extends Callback ? Parameters<X> : unknown[]) => boolean;
    processFirstArg?: (firstArgument: unknown) => unknown;
};
export declare class DebounceClass extends Pseudo {
    HitProcessors: {
        readonly PlayerCharacter: (hit: unknown, targetPlayer?: Player) => Player | undefined;
        readonly MyCharacter: (hit: BasePart) => Player | undefined;
    };
    Debounce<T extends DebounceParams<X>, X extends RBXScriptSignal | Callback>(debouncer: T): any;
    Debounce<input extends RBXScriptSignal>(debouncer: input, callback: Callback, time?: number, firstArgDebounce?: boolean, connectParallel?: boolean): RBXScriptConnection;
    Debounce<input extends Callback>(debouncer: input, time?: number, firstArgDebounce?: boolean): input;
    constructor();
}
declare const Debouncer: DebounceClass;
export { Debouncer };
export default Debouncer;
