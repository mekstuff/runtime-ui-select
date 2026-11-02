import Debouncer from "./class/Debounce/Debounce";
import RecursiveTry from "./internal/functions/RecursiveTry";
import BatchIterate from "./internal/functions/BatchIterate";
import { Servant, ServantPromise, ServantTrackableItem } from "./class/Servant/Servant";
import { Pseudo } from "./class/Pseudo/Pseudo";
import { _typeIs } from "./internal/functions/typeIs";
import { Engine } from "./class/Engine/Engine";
import { GetPseudoById } from "./internal/functions/GetPseudoById";
import { PseudoClientReplicator } from "./class/Replication/PseudoClientReplicator";
import { State } from "./class/State/State";
import { PseudoReplicator } from "./class/Replication/PseudoReplicator";
import { Signal } from "./class/Signal/Signal";
import { Compatibility } from "./class/Compatibility/Compatibility";
import { Observables } from "./class/Observables/Observables";
import { InstanceMapper } from "./class/InstanceMapper/InstanceMapper";
import { Spring } from "./class/Spring/Spring";
import { Cache } from "./class/Cache/Cache";
import Queue from "./class/Queue/Queue";
import { ObserveCallback, ObserveDependency, ObserveDependencies, ObserveListener, usePropertyEffectCleanup } from "./class/Pseudo/Pseudo";
import { GetPseudoFromObject } from "./internal/functions/GetPseudoByObject";
import { tryUseEffectCleanup } from "./internal/functions/CalluseEffectServant";
import { Effect, EffectFunctionObject } from "./internal/functions/Effect/Effect";
import RuntimeDebugger from "./class/RuntimeDebugger/RuntimeDebugger";
import { PowerHorse } from "./internal/PowerHorse";
export interface PowerHorseEngineTypes {
    InternalPseudoTypes: {
        Pseudo: Pseudo;
        ObserveCallback: ObserveCallback;
        ObserveDependency: ObserveDependency;
        ObserveDependencies: ObserveDependencies;
        ObserveListener: ObserveListener;
        usePropertyEffectCleanup: usePropertyEffectCleanup;
        EffectFunctionObject: EffectFunctionObject;
    };
}
export { Signal, Pseudo, Servant, ServantTrackableItem, PseudoClientReplicator, State, Spring, PHe, Queue, Cache, RuntimeDebugger, PowerHorse, Compatibility, Observables, InstanceMapper, Debouncer, Engine, Effect, ServantPromise, _typeIs as typeIs, GetPseudoById, GetPseudoFromObject, tryUseEffectCleanup, RecursiveTry, BatchIterate, };
declare global {
    namespace PHe {
        /** A list of pseudo classes*/
        interface Pseudos {
            Signal: Signal;
            Servant: Servant;
            Pseudo: Pseudo;
            State: State;
            PseudoClientReplicator: PseudoClientReplicator;
            PseudoReplicator: PseudoReplicator;
        }
        /**Classes that should be able to be created with `new` constructor*/
        interface CreateablePseudos {
            Signal: Signal;
            Servant: Servant;
            State: State;
        }
        /**
         * Types that can be checked with custom _typeIs.
         */
        interface CheckablePseudos {
            Signal: Signal;
            Pseudo: Pseudo;
            Servant: Servant;
            State: State;
            PseudoClientReplicator: PseudoClientReplicator;
            PseudoReplicator: PseudoReplicator;
        }
        /**
         * Types that can be checked with custom _typeIs, including `CheckableTypes` for luau.
         */
        type CheckablePseudoInstanceTypes = CheckablePseudos & CheckableTypes & {
            SignalConnection: {
                Disconnect: (this: unknown) => void;
            };
        };
        type Enums = {};
    }
}
