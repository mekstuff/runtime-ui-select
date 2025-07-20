import { Pseudo, usePropertyEffectCleanup } from "../Pseudo/Pseudo";
import { Servant } from "../Servant/Servant";
import { SyncerUsageClass } from "./Syncer";
export declare class SyncedContent extends Pseudo {
    private _Syncer;
    readonly Initialized: boolean;
    Value: unknown;
    Sync(): void;
    useValue(Callback: (value: unknown) => usePropertyEffectCleanup): Servant;
    constructor(SyncId: string, _Syncer: SyncerUsageClass, _initialValueNoServerCheck?: unknown);
}
