import { PseudoCollector } from "../../internal/functions/GetPseudoById";
import { Pseudo } from "../Pseudo/Pseudo";
import RuntimeDebugger from "./RuntimeDebugger";
export declare class RuntimeDebuggerRoot extends Pseudo {
    private UserUsageList;
    private IsActiveFromUserUsage;
    SharedPseudoCollector: typeof PseudoCollector;
    GetIsVerifiedUsageUser(Player: Player): boolean;
    AddUserUsage(Player: Player): void;
    RemoveUserUsage(Player: Player): void;
    constructor(RuntimeDebugger: RuntimeDebugger);
}
