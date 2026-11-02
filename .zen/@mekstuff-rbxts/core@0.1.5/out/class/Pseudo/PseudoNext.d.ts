import { PSEUDO_G } from "../../internal/functions/PSEUDO_G";
import { PseudoReplicator } from "../Replication/PseudoReplicator";
import { Servant } from "../Servant/Servant";
import { Signal } from "../Signal/Signal";
import {
	ObserveCallback,
	ObserveDependencies,
	ObserveListener,
	PseudoDevDefs,
	CreatableReferenceInstanceType,
	usePropertyEffectCleanup,
} from "./Pseudo";

type ObserveForEachCallback<K = unknown, V = unknown> = (
	key: K,
	value: V,
	dependencyGroup: string,
) => usePropertyEffectCleanup;

/**
 * useMappingEffect(["Name"])
 * useMappingEffect([{"Name": "Name"}])
 */
type useMappingEffectProperties = (string | Record<string, string>)[];

interface PseudoNext<T extends object | unknown = unknown, _REF extends Instance = Folder> {
	_G: typeof PSEUDO_G;

	$client:
		| ((
				initializedServant: Servant,
				PseudoClientReplicator: PHe.Pseudos["PseudoClientReplicator"],
		  ) => (() => void) | void)
		| undefined;
	$server:
		| ((
				initializedServant: Servant,
				PseudoClientReplicator: PHe.Pseudos["PseudoClientReplicator"],
		  ) => (() => void) | void)
		| undefined;

	/**
	 * NOTE: Using the Replicator on the client can lead based on the current status of the Replicator.
	 */
	Replicator: PseudoReplicator;
	HasReplicator(): boolean;
	EnableReplication(filter?: string[], filterType?: Enum.RaycastFilterType): void;
	/**
	 * Returns the ID of the Server Pseudo that it Replicates. On the Server, it will always be the same as `GetIdAsync()`. But on the client
	 * it will be the ID of the Server Pseudo. On the client, this function will return nil if the Pseudo was not Replicated or it didn't extend a Pseudo class
	 * initially.
	 */
	GetServerReplicationId(): string | undefined;

	warn(...args: unknown[]): void;
	log(...args: unknown[]): void;
	error(err: unknown, level?: number): never;
	assert(condition: unknown, err?: unknown): asserts condition;

	/**
	 * Unique identifier for the Pseudo.
	 *
	 * Use `GetIdAsync()` over `_id`.
	 */
	_id: string;

	GetIdAsync(): string;

	/**
	 * The parent of the pseudo object
	 */
	Parent: Instance | PseudoNext | undefined;
	/**
	 * The ClassName of the Pseudo
	 */
	readonly ClassName: string;

	readonly _classNames: string[];

	/**
	 * The Name of the Pseudo
	 */
	Name: string;

	/**
	 * A unique container where items about the pseudo should be stored. Anything within this container will be destroyed/cleaned up
	 * whenever the pseudo is destroyed. (Good for storing Servants,Maids,etc.)
	 *
	 * It is recommended to use the `set`, `get` and `insert` functions of _dev rather than directly setting new values - There's optimizations implemented internally
	 * and it will boost your game perfomance and lower memory usage significantly.
	 */
	_dev: PseudoDevDefs & T;

	/**
	 * Creates the signal only when it is required. Use `GetSignal` if you wish to create the signal.
	 */
	CreateSignal(SignalName: string): void;
	/**
	 * Creates the signal if it doesn't exist, Gurantees the signal will exist at this point in time and be returned.
	 */
	GetSignal<T extends Callback>(SignalName: string): Signal<T>;
	/**
	 * @returns If the signal exists/will exist if indexed.
	 */
	HasSignal(SignalName: string): boolean;

	/**
	 * Returns the reference instance of the pseudo
	 *
	 * The reference Instance will not exist prior to the first call of this method for optimization sake.
	 */
	GetRef<T = Folder>(): T;
	HasRef(): boolean;

	/**
	 * Will execute the callback initially on a different thread using the task library. `task.spawn`.
	 */
	ObserveTask(Callback: ObserveCallback, dependencies?: ObserveDependencies): Servant;

	Observe(dependencies: ObserveDependencies): ObserveListener;
	Observe(Callback: ObserveCallback, dependencies?: ObserveDependencies): Servant;
	/**
	 *
	 * Unlike `usePropertyEffect`, You cannot yield within an Observe callback and also passes a `Servant` argument.
	 *
	 * With that Servant, you can then add cleanup logic "per-block" within your code. @see [Servant.Keep]
	 *
	 */
	Observe(
		Callback: ObserveCallback | ObserveDependencies,
		dependencies?: ObserveDependencies,
	): Servant | ObserveListener;

	/**
	 * @deprecated
	 *
	 * `Observe()` will always run immediately, on the same thread. 12/8/24
	 *
	 * The initial run will be called immediately on the thread with `task.spawn`. `Observe` executes your initial call
	 * on the end of the thread with `task.defer`, note that any following calls will execute at the end of the thread.
	 */
	ObserveNow(Callback: ObserveCallback, dependencies?: ObserveDependencies): Servant;

	/**
	 * Will only run the callback once when it is triggered and removes the Observer after.
	 *
	 * Similar to doing:
	 *
	 * ```ts
	 * const Observer = this.ObserveNext(() => {
	 * 	Observer.Destroy()
	 * 	// Code...
	 * }, ...)
	 * ```
	 */
	ObserveOnce(Callback: ObserveCallback, dependencies?: ObserveDependencies): Servant;

	ObserveNext(Callback: ObserveCallback, dependencies?: ObserveDependencies, CallbackQueue?: number): Servant;

	ObserveForEach<K, V>(Callback: ObserveForEachCallback<K, V>, tableDepedencies: string[]): Servant;

	/**
	 * Maps the listed self.`Properties` values to the listed `Dependencies`.
	 */
	useMappingEffect(Properties: useMappingEffectProperties, Dependencies: (Instance | PseudoNext)[]): Servant;
	/**
	 * Similar to `useMappingEffect` but is two way. meaning both `this` and `Dependencies` will always have the same `Properties`.
	 *
	 * useMappingEffect: Property of this changes - Updates dependencies
	 * useBindingEffect: Property of this changes - Updates dependencies && Property of a dependency changes - Updates this.
	 */
	useBindingEffect(Properties: useMappingEffectProperties, Dependencies: (Instance | PseudoNext)[]): Servant;

	/**
	 * Fired when the Pseudo is being destroyed.
	 */
	Destroying: Signal;
	/**
	 * Destroys the Pseudo.
	 */
	Destroy(): void;

	/**
	 * Run a function whenever `Pseudo` is being `Destroyed`
	 *
	 * It is recommended to use the .Destroying event over this method as it is slower.
	 *
	 * @resturns Sevant
	 */
	useDestroying(callback: Callback): Servant;

	/**
	 * Returns if the Pseudo is Destroyed
	 */
	IsDestroyed(): boolean;

	/**
	 * Gets the currently assigned properties of the `pseudo`
	 *
	 * @param excludeKeys Will not include the given keys, think of it as a blacklist filter.
	 * @param IncludeHiddenProps Hidden props are considered properties that begin with `_`
	 * @param IncludeFunctions Both methods and callbacks are considered functions. (NOTE: functions by classes that inherit pseudo cannot be read, only `Pseudo` functions will exist. )
	 * @param IncludeSignals Will include RBXScriptSignals and some third party library signals, if item has a ClassName of `Signal` | `RBXScriptSignal` it will be considered a signal.
	 * @param AsDictionary Returns the objects as a dictionary with their values.
	 */
	_getCurrentProperties(
		excludeKeys?: unknown[],
		IncludeHiddenProps?: boolean,
		IncludeFunctions?: boolean,
		IncludeSignals?: boolean,
		AsDictionary?: boolean,
	): unknown[] | Record<string | number, unknown>;

	PrePropertyChanged: Signal<(Key: unknown, Value: unknown) => void>;
	PropertyChanged: Signal<(Key: unknown, Value: unknown) => void>;
	GetPropertyChangedSignal(PropertyName: string): Signal<(Value: unknown) => void>;

	CreateServantAsync(): Servant;

	IsA<T extends keyof PHe.Pseudos>(this: PHe.Pseudos["Pseudo"], ClassName: T): this is PHe.Pseudos[T];

	useIndexAssignment(callback: (key: unknown, value: unknown) => unknown): void;
	useNewIndexAssignment(key: unknown, value: unknown): void;
	useAssignReadonlyProperty(Property: unknown, Value: unknown): void;

	/**
	 * @hidden
	 * @private
	 *
	 * Will be called whenever the Pseudo object is called. e.g. PseudoNext()
	 * @returns
	 */
	__metamethod_call?(...args: unknown[]): unknown;
}

export interface PseudoNextConstructor {
	new <T extends object | unknown = unknown, _REF extends Instance = Folder>(
		ClassName: string,
		ReferenceInstanceType?: CreatableReferenceInstanceType,
	): PseudoNext<T>;
}

declare const PseudoNext: PseudoNextConstructor;

// Replication types (Pseudo-Client-Replicator/init.client.lua)

/**
 * Modules tagged with `PowerHorse.ClientRuntimeApi` will access this api.
 */
type PowerHorseApiRuntimeClientApi = {
	ApiKey: string;
	/**
	 * Whenever an object is being replicated, the client receives the module/data
	 * that it should build the object from. Here you can intercept right before the module is
	 * built with Pseudo.
	 */
	onReplicatedTargetModuleResolved: (Callback: (Object: any, ServerSideId: string) => object) => Servant;
};
type PowerHorseApiRuntimeClient = {
	PowerHorseInit: (api: PowerHorseApiRuntimeClientApi) => void;
};

export { PseudoNext, PowerHorseApiRuntimeClient };
