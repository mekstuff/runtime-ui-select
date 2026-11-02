import { Pseudo } from "../Pseudo/Pseudo";
export declare class CompatibilityUsageClass extends Pseudo {
    private _activeFunction;
    constructor(Compat: CompatibilityClass, ...args: unknown[]);
}
export declare class CompatibilityClass extends Pseudo {
    TouchEnabled: boolean;
    GamepadEnabled: boolean;
    IsTenFootInterface: boolean;
    KeyboardEnabled: boolean;
    constructor();
}
declare const Compatibility: CompatibilityClass;
export { Compatibility };
export default Compatibility;
