import { Pseudo } from "../Pseudo/Pseudo";
import { Signal } from "../Signal/Signal";
type OmitFirstArg<F> = F extends (x: any, ...args: infer P) => infer R ? (...args: P) => R : never;
declare class Queue<T = unknown> extends Pseudo {
    readonly Queue: {
        value: T;
        priority: number;
        t: number;
    }[];
    Acsending: boolean;
    QueueEmpty: boolean;
    QueueEmptied: Signal;
    AutoExecutions: boolean;
    private _autoExecuting;
    readonly PreviousPriority: number | undefined;
    readonly CurrentPriority: number | undefined;
    private _initAutoExecutions;
    private _isDestroyed;
    IsEmpty(): boolean;
    Clear(): void;
    /**
     *
     */
    Execute(Callback: (CurrentPriority: this["CurrentPriority"], PreviousPriority: this["PreviousPriority"]) => Signal | void, ...args: Parameters<OmitFirstArg<Queue["Enqueue"]>>): void;
    Enqueue(Value: T, Priority?: number): void;
    Dequeue(): T | undefined;
    constructor();
}
export { Queue };
export default Queue;
