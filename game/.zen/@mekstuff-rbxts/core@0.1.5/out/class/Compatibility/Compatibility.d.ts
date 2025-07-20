import { Pseudo } from "../Pseudo/Pseudo";
export declare class CompatibilityUsageClass extends Pseudo {
    private _activeFunction;
    constructor(Compat: CompatibilityClass, ...args: unknown[]);
}
export declare class CompatibilityClass extends Pseudo {
    IsTouchDevice: boolean;
    IsGamepadDevice: boolean;
    IsTenFootInterface: boolean;
    use(...args: Parameters<CompatibilityClass["useCompatibility"]>): ReturnType<CompatibilityClass["useCompatibility"]>;
    useCompatibility(...args: unknown[]): any;
    constructor();
}
declare const Compatibility: CompatibilityClass;
export { Compatibility };
export default Compatibility;
