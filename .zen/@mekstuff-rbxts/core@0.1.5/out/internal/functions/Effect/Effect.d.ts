import { Pseudo, usePropertyEffectCleanup } from "../../../class/Pseudo/Pseudo";
import { Servant } from "../../../class/Servant/Servant";
import { State } from "../../../class/State/State";
export type EffectFunctionObject = {
    Destroy: () => void;
    _servant: Servant;
    _inject_state: (state: State<any>) => void;
    _reactive_pseudos_map: Map<Pseudo, object>;
};
declare function _CreateReactivePseudo<T extends Pseudo>(object: T): T;
/**
 * Makes any direct index of the Pseudo provided reactive (Your effect will re-render whenever the property of whatever you indexed changes)
 *
 * e.g.
 *
 * ```ts
 * Effect((r) => {
 * 	r(Compatibility).GamepadEnabled;
 * 	print(gamepadEnabled);
 * 	// Reruns function anytime "GamepadEnabled" for "Compatibility" changes.
 * })
 * ```
 */
type CreateReactivePseudoType = typeof _CreateReactivePseudo;
/**
 * Use call method on `State` objects within your callback to inject them as dependencies.
 *
 * Effects are always ran at the start of the next frame.
 *
 * ```ts
 * const State = new State(1)
 *
 * Effect(() => {
 * 	print(State()) // 1, then 2 after delay
 * })
 *
 * task.delay(.5, () => {
 * 	State.SetState(2)
 * })
 *
 * ```
 *
 * @param callback Will rerun when any state dependency that is called within the function state changes.
 * @returns
 */
declare function EffectFunction(callback: (r: CreateReactivePseudoType) => usePropertyEffectCleanup): EffectFunctionObject;
export declare function getCurrentRunningEffectObject(): EffectFunctionObject | undefined;
export { EffectFunction as Effect };
