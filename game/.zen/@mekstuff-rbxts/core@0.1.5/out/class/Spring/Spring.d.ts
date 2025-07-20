import { Signal } from "../Signal/Signal";
import { State } from "../State/State";
export declare class Spring<T> extends State<T> {
    Damping: number;
    Frequency: number;
    private _activeStateGoal;
    Completed: Signal;
    /**
     * Always use `setGoal` over `setState` when using Springs.
     */
    SetGoal(...args: Parameters<State<T>["setState"]>): ReturnType<State<T>["setState"]>;
    Disrupt(Goal: T, Damping?: number, Frequency?: number): void;
    ResetGoal(Goal: T): void;
    constructor(DefaultValue?: T, Damping?: number, Frequency?: number);
}
