import { Pseudo } from "../Pseudo/Pseudo";
import { Servant } from "../Servant/Servant";
import { SyncedContent } from "./SyncedContent";
export declare enum SyncingMethod {
    default = 0,
    attr = 1
}
export declare class SyncerUsageClass extends Pseudo {
    SyncingMethods: typeof SyncingMethod;
    private _ServerCoreSyncerRemote;
    /**
     * @server
     */
    private _getSyncedDataForKey;
    /**
     * @server
     */
    private _getSyncedCatchData;
    GetSynced(SyncId: string, Target: Player | number): unknown;
    /**
     * @server
     */
    Sync(SyncId: string, SyncData: any, SyncTo?: Player | Player[] | number | number[] | "*", SyncingMethod?: SyncingMethod): void;
    constructor();
    /**
     * @client
     */
    useSync(SyncId: string, Callback?: (SyncedContent: SyncedContent) => void): SyncedContent;
    /**
     * @client
     */
    useCatch(CatchId: string, Callback: (SyncedContent: SyncedContent, Id: string) => void): Servant;
}
declare const Syncer: SyncerUsageClass;
export { Syncer };
export default Syncer;
