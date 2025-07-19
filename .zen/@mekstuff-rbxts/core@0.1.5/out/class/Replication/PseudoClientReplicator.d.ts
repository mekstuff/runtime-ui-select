/**
 * Olanzo @ mekstuff
 */
import { Pseudo } from "../Pseudo/Pseudo";
import { Signal } from "../Signal/Signal";
/**
 * `PseudoClientReplicator` is a Pseudo class that is created whenever Replication is enabled within a Pseudo class. It is passed as a second
 * argument to both the $server and $client replication constructor functions.
 */
export declare class PseudoClientReplicator extends Pseudo {
    private pseudoOriginator;
    Disconnected: Signal;
    private _initialized;
    private _ref;
    private _internal__totalPCRUsageEntries;
    private _initializeClient;
    /**
     * @client
     *
     * Gets the remote event
     */
    GetRemote(RemoteName: string): RemoteEvent;
    /**
     * @server
     *
     * Creates a remote event, Only one remote event will exist with the same name, if the remote name already exists, it will return the "original"
     * remote event.
     */
    CreateRemote(RemoteName: string): RemoteEvent;
    /**
     * Must be called to initialize the clients.
     *
     * @param clientReplicator The ModuleScript which the client will use to build the replication pseudo class.
     * @param targetClients Optional parameter of a list of players that this item should *only* be replicated to.
     */
    InitializeClients(clientReplicator: ModuleScript | object, targetClients?: Player[], replicationSerializer?: unknown): void;
    _createCommunicationBindable(PlayerWhoRequested: Player, funcName: string): void;
    constructor(pseudoOriginator: Pseudo);
}
