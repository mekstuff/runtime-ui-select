/**
 * A `ClientReplicator` is a `Replicator` for the client, it is used to communicate to the server.
 *
 * It directly adds the .Replicator to the `object` provided if .Replicator isn't already provided.
 */
export declare function CreateClientReplicator(object: unknown): {
    Define: (_: unknown, __: unknown, ...args: unknown[]) => any;
    Transmit: (_: unknown, __: unknown, func: Callback, ...args: unknown[]) => any;
    WithDebounce: (_: unknown, cb: unknown) => unknown;
};
