import { Pseudo, usePropertyEffectCleanup } from "../Pseudo/Pseudo";
export declare class State<T = undefined> extends Pseudo {
    State: T;
    protected internalSetStateCallback: ((queryValue: T, currentValue: T) => void) | undefined;
    setState(Callback: (oldState: T) => T): void;
    setState(state: T): void;
    use(): State<T>;
    useStateEffect(Callback?: (value: T) => usePropertyEffectCleanup): PHe.Pseudos["Servant"];
    useState<X = unknown>(Callback: (state: T) => undefined | X | LuaTuple<[X, usePropertyEffectCleanup?]>): State<X>;
    /**
     *
     * @param State Updating this value directly without using setState will not update the Name to display the state value.
     */
    constructor(State?: T);
}
