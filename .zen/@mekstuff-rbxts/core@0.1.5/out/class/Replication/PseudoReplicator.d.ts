import { Pseudo } from "../../index";
type TransmitterData = {
    Player: Player;
    /**
     * Only a single TransmitterId can exist at a time, meaning reusing the same ID will remove any
     * previous entries of it and drop any previous results. By default, this value is random.
     */
    TransmitterId?: string;
    /**
     * Cancels the Promise after the Timeout ends, voiding the Transmitter. Defaults to 2 mintues
     */
    TransmitterTimeout?: number;
};
/**
 * A class that is created whenever EnabledReplication is called on a Pseudo object. The PseudoReplicator of that class can be accessed using
 * `Pseudo.Replicator`. (Note that it only exists after `EnableReplication` is called and is available on both the server and the client.)
 */
export declare class PseudoReplicator extends Pseudo {
    private _PseudoOrigin;
    /**
     * Add a debounce to your callback using `Debouncer`.
     *
     * For `Transmit` debounces on the server side, use TransmitWithDebounce()
     *
     * @param [FirstArgumentIsDebounced=true] defaults to true.
     */
    WithDebounce<T extends Callback>(Callback: T, Time?: number, FirstArgumentIsDebounced?: boolean): T;
    /**
     * For Client->Server Communication
     *
     * Note that there's a possibility that this method will yield if the Replicator isn't available at the time it is called.
     *
     * ```ts
     * class ... extends Pseudo {
     * 	...
     * 	public aFunctionThatClientCanCallServer(...args: unknown[]){
     * 		return this.Replicator.Define((Player, ...args) => {
     * 			...
     * 		}, ...args)
     * 	}
     * }
     * ```
     */
    Define<T>(Callback?: (Player: Player, ...args: unknown[]) => T, ...args: unknown[]): Promise<T>;
    /**
     * Send a Transmission without expecting a response from the Client. Same as FireClient of a Remote Event.
     * Good for notifications or event triggers.
     */
    TransmitMessage<T>(Client: Player | TransmitterData, Callback?: (...callbackArgs: any[]) => T, // we do not call the "callback" on the server, it is executed on the client.
    ...args: unknown[]): void;
    /**
     * For Server->Client Communication
     *
     * Note that the Promise returned will never internally reject unless it was
     * triggered by an error. If the Transmitter is timed out and/or failed, it will always
     * resolve but with no value.
     *
     * ```ts
     * class ... extends Pseudo {
     * 	...
     * 	public aFunctionTheServerCanCallClient(Player: Player, ...args: unknown[]){
     * 		return this.Replicator.Transmit((Player) => {
     * 			// This will execute on the client that is passed at the first param
     * 			...
     * 			return 1
     * 		}, ...args)
     * 	}
     * }
     *
     * public aFunctionTheServerCanCallClient(...).expect() --> 1
     * ```
     *
     * Use this method with caution as data received from client cannot be trusted, the thread doesn't pause since TransmitMessage uses IDs and RemoteEvents instead of RemoteFunction invokation.
     * Use TransmitMessage() if you only wish to send out data but don't require a response.
     */
    Transmit<T>(Client: TransmitterData | Player, Callback?: (...callbackArgs: any[]) => T, // we do not call the "callback" on the server, it is executed on the client.
    ...args: unknown[]): Promise<T | undefined>;
    ResolveTransmitter(TransmitterId: string, Successful: boolean, ...data: unknown[]): void;
    constructor(_PseudoOrigin: Pseudo);
}
export {};
