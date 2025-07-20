import { Pseudo } from "../Pseudo/Pseudo";
import Iris_TypeDefImport from "@rbxts/iris";
type Iris_TypeDef = typeof Iris_TypeDefImport;
export default class RuntimeDebugger extends Pseudo {
    private _PCR;
    private RuntimeDebuggerRoot;
    private MainWindowOpened;
    private PseudoEntiresDebuggerOpened;
    private ServerSectionCollapsed;
    toNumberCommas(value: number): string;
    private ClientSharedPseudoCollectorServerFetched;
    private RunGetRuntimeDebuggerSharedPseudoCollector;
    addRuntimeDebuggerRootUsageServer(...args: unknown[]): Promise<void>;
    removeRuntimeDebuggerRootUsageServer(...args: unknown[]): Promise<void>;
    PowerHorseEngineDebuggerWindow(Iris: Iris_TypeDef): void;
    PseudoEntriesModifierWindow(Iris: Iris_TypeDef): void;
    constructor(TargetClient: Player);
}
export {};
