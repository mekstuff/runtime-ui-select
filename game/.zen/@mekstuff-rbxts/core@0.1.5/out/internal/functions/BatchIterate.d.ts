import { Pseudo } from "../../class/Pseudo/Pseudo";
import { Signal } from "../../class/Signal/Signal";
import { Queue } from "../../class/Queue/Queue";
type BatchIterate = {
    new: <Args>(...args: ConstructorParameters<typeof BatchIterator<Args>>) => BatchIterator<Args>;
} & ((Content: object, Callback: Callback, Segments?: number, BatchYieldTime?: number, Sequential?: boolean) => Signal);
declare class BatchIterator<Args = unknown> extends Pseudo {
    private Callback;
    private Segments;
    private BatchYieldTime;
    private Sequential;
    private _segmentIndex;
    private _segnmentQueuePriority;
    Queue: Queue;
    private AddEntryCore;
    AddEntry(...args: Args[]): void;
    AddSequentialEntry(...args: Args[]): void;
    AddParallelEntry(...args: Args[]): void;
    AddSequentialEnd(): void;
    constructor(Callback: (...args: Args[]) => unknown, Segments?: number, BatchYieldTime?: number, Sequential?: boolean);
}
declare function BatchIterateObject(Content: object, Callback: Callback, Segments?: number, BatchYieldTime?: number, Sequential?: boolean): Signal;
declare const BatchIterate: BatchIterate;
export default BatchIterate;
export { BatchIterate, BatchIterator, BatchIterateObject };
