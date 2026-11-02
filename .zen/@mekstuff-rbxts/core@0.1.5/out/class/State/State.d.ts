import { Pseudo, usePropertyEffectCleanup } from "../Pseudo/Pseudo";
export interface State<T> extends Pseudo {
    /**
     * Use `State` within an `Effect` to make the `Effect` reactive, Calling State() should **NOT** be done outside an `Effect`, it will throw an error.
     * use `State.State` to access state value outside an `Effect`.
     */
    (): T;
}
export declare class State<T = undefined> extends Pseudo {
    State: T;
    protected internalSetStateCallback: ((queryValue: T, currentValue: T) => void) | undefined;
    SetState(Callback: (oldState: T) => T): void;
    SetState(state: T): void;
    Use(): State<T>;
    UseStateEffect(Callback?: (value: T) => usePropertyEffectCleanup): PHe.Pseudos["Servant"];
    UseState<X = unknown>(Callback: (state: T) => undefined | X | LuaTuple<[X, usePropertyEffectCleanup?]>): State<X>;
    __metamethod_call(): T;
    /**
     *
     * @param State Updating this value directly without using SetState will not update the Name to display the state value.
     */
    constructor(State?: T);
}
