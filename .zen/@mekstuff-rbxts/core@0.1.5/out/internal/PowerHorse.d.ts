import { ObserveCallback } from "../class/Pseudo/Pseudo";
import { Servant } from "../class/Servant/Servant";
import { Signal } from "../class/Signal/Signal";
import { _typeIs } from "./functions/typeIs";
import { GetPseudoById } from "./functions/GetPseudoById";
import { GetPseudoFromObject } from "./functions/GetPseudoByObject";
import RecursiveTry from "./functions/RecursiveTry";
import BatchIterate from "./functions/BatchIterate";
import RuntimeDebugger from "../class/RuntimeDebugger/RuntimeDebugger";
import { Cache } from "../class/Cache/Cache";
declare const PowerHorse: {
    _G: UnknownArray & {
        set: (key: unknown, value: unknown) => void;
        get: <T>(key: unknown, timeout?: number) => Promise<T>;
    };
    Pseudo: import("../class/Pseudo/PseudoNext").PseudoNextConstructor;
    State: {};
    Spring: {};
    Servant: import("../class/Servant/ServantNext").ServantNextConstructor;
    Signal: typeof Signal;
    SpreadOperator: (...t: object[]) => {};
    typeIs: typeof _typeIs;
    GetPseudoById: typeof GetPseudoById;
    GetPseudoFromObject: typeof GetPseudoFromObject;
    RecursiveTry: typeof RecursiveTry;
    BatchIterate: BatchIterate;
    Color3: {
        new: (r: number | Color3, g: number, b: number, alpha?: number) => Color3;
        fromRGB: (r: number, g: number, b: number, alpha?: number) => Color3;
        fromHSV: (h: number, s: number, v: number, alpha?: number) => Color3;
        adjustHSV: (inputColor: Color3, saturation?: number, value?: number) => Color3;
    };
    Engine: {
        InitServer: () => void;
        FetchReplicatedStorage: (TargetSubContainer?: string) => Instance;
        FetchWorkspaceStorage: (TargetSubContainer?: string) => Instance;
        FetchServerStorage: (TargetSubContainer?: string) => Instance;
        FetchServerScripts: (TargetSubContainer?: string) => Instance;
    };
    Compatibility: import("../class/Compatibility/Compatibility").CompatibilityClass;
    Observables: import("../class/Observables/Observables").ObservablesClass;
    RuntimeDebugger: typeof RuntimeDebugger;
    InstanceMapper: import("../class/InstanceMapper/InstanceMapper").InstanceMapperClass;
    Debouncer: import("../class/Debounce/Debounce").DebounceClass;
    Cache: typeof Cache;
    Promise: PromiseConstructor;
    /**
     * Create an Observer for an Instance
     *
     * @param Dependencies "Property" for a Property of the Instance, "#Attribute" for an Attribute of the Instance.
     */
    ObserveInstance<T extends Instance>(Instance: T, Callback: ObserveCallback, Dependencies: (keyof T | `#${string}`)[]): {
        _G: typeof import("./functions/PSEUDO_G").PSEUDO_G;
        $client: ((initializedServant: Servant, PseudoClientReplicator: PHe.Pseudos["PseudoClientReplicator"]) => (() => void) | void) | undefined;
        $server: ((initializedServant: Servant, PseudoClientReplicator: PHe.Pseudos["PseudoClientReplicator"]) => (() => void) | void) | undefined;
        Replicator: import("../class/Replication/PseudoReplicator").PseudoReplicator;
        HasReplicator(): boolean;
        EnableReplication(filter?: string[], filterType?: Enum.RaycastFilterType): void;
        GetServerReplicationId(): string | undefined;
        warn(...args: unknown[]): void;
        log(...args: unknown[]): void;
        error(err: unknown, level?: number): never;
        assert(condition: unknown, err?: unknown): asserts condition;
        _id: string;
        GetIdAsync(): string;
        Parent: Instance | import("../class/Pseudo/PseudoNext").PseudoNext | undefined;
        readonly ClassName: string;
        readonly _classNames: string[];
        Name: string;
        _dev: {
            [key: string]: unknown;
            [key: number]: unknown;
            [key: symbol]: unknown;
            get: (targetItem: string | number) => unknown;
            has: (targetItem: unknown) => boolean;
            set: (targetItem: string | number, targetValue: unknown) => void;
            insert: (item: unknown) => void;
            _internal_runtime_debug_info: {
                creationTimestamp: number;
            };
        } & UnknownArray;
        CreateSignal(SignalName: string): void;
        GetSignal<T_1 extends Callback>(SignalName: string): Signal<T_1>;
        HasSignal(SignalName: string): boolean;
        GetRef<T_1 = Folder>(): T_1;
        HasRef(): boolean;
        ObserveTask(Callback: ObserveCallback, dependencies?: import("../class/Pseudo/Pseudo").ObserveDependencies): Servant;
        Observe(dependencies: import("../class/Pseudo/Pseudo").ObserveDependencies): import("../class/Pseudo/Pseudo").ObserveListener;
        Observe(Callback: ObserveCallback, dependencies?: import("../class/Pseudo/Pseudo").ObserveDependencies): Servant;
        Observe(Callback: ObserveCallback | import("../class/Pseudo/Pseudo").ObserveDependencies, dependencies?: import("../class/Pseudo/Pseudo").ObserveDependencies): Servant | import("../class/Pseudo/Pseudo").ObserveListener;
        ObserveNow(Callback: ObserveCallback, dependencies?: import("../class/Pseudo/Pseudo").ObserveDependencies): Servant;
        ObserveOnce(Callback: ObserveCallback, dependencies?: import("../class/Pseudo/Pseudo").ObserveDependencies): Servant;
        ObserveNext(Callback: ObserveCallback, dependencies?: import("../class/Pseudo/Pseudo").ObserveDependencies, CallbackQueue?: number): Servant;
        ObserveForEach<K, V>(Callback: (key: K, value: V, dependencyGroup: string) => import("../class/Pseudo/Pseudo").usePropertyEffectCleanup, tableDepedencies: string[]): Servant;
        useMappingEffect(Properties: (string | Record<string, string>)[], Dependencies: (Instance | import("../class/Pseudo/PseudoNext").PseudoNext)[]): Servant;
        useBindingEffect(Properties: (string | Record<string, string>)[], Dependencies: (Instance | import("../class/Pseudo/PseudoNext").PseudoNext)[]): Servant;
        Destroying: Signal;
        Destroy(): void;
        useDestroying(callback: Callback): Servant;
        IsDestroyed(): boolean;
        _getCurrentProperties(excludeKeys?: unknown[], IncludeHiddenProps?: boolean, IncludeFunctions?: boolean, IncludeSignals?: boolean, AsDictionary?: boolean): unknown[] | Record<string | number, unknown>;
        PrePropertyChanged: Signal<(Key: unknown, Value: unknown) => void>;
        PropertyChanged: Signal<(Key: unknown, Value: unknown) => void>;
        GetPropertyChangedSignal(PropertyName: string): Signal<(Value: unknown) => void>;
        CreateServantAsync(): Servant;
        IsA<T_1 extends keyof PHe.Pseudos>(this: PHe.Pseudos["Pseudo"], ClassName: T_1): this is PHe.Pseudos[T_1];
        useIndexAssignment(callback: (key: unknown, value: unknown) => unknown): void;
        useNewIndexAssignment(key: unknown, value: unknown): void;
        useAssignReadonlyProperty(Property: unknown, Value: unknown): void;
        __metamethod_call?(...args: unknown[]): unknown;
    };
    setNodeModules(node_modules: Folder): void;
    createClass(constructor: (...args: unknown[]) => any, ...args: unknown[]): any;
    PKG: {};
    _getluaprovider(): {
        require: Callback;
        class: Callback;
    } | undefined;
    luaproviderRequire(module: ModuleScript): any;
    require(root: string | Instance, path?: string): unknown;
    importAsync(root: string | Instance, path?: string): unknown;
    import(root: string | Instance, path?: string): Promise<unknown>;
    error: (err: unknown, level?: number) => never;
    warn: (...args: unknown[]) => void;
    log: (...args: unknown[]) => void;
};
export { PowerHorse };
