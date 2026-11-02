import { Signal } from "../Signal/Signal";
import { State } from "../State/State";
export declare class Spring<T> extends State<T> {
    Damping: number;
    Frequency: number;
    private _activeStateGoal;
    Completed: Signal;
    /**
     * Always use `setGoal` over `SetState` when using Springs.
     */
    SetGoal(...args: Parameters<State<T>["SetState"]>): ReturnType<State<T>["SetState"]>;
    Disrupt(Goal: T, props?: {
        Damping?: number;
        Frequency?: number;
        Lifetime?: number;
    }): void;
    ResetGoal(Goal: T): void;
    constructor(DefaultValue?: T, Damping?: number, Frequency?: number);
}
