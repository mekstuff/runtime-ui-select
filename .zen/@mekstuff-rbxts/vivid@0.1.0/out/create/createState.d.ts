import { Signal, State } from "@mekstuff-rbxts/core";
import { ObserveListener } from "@mekstuff-rbxts/core/out/class/Pseudo/Pseudo";
export type VividState<T> = () => T;
export type VividSetStateCallback<T> = (cb: (oldValue: T) => T) => void;
export type VividSetStateInput<T> = (newValue: T) => void;
export type VividSetState<T> = VividSetStateCallback<T> & VividSetStateInput<T>;
export type StatePropertyValue = {
    _isstatepropval: boolean;
    _state: State<unknown>;
    _call: VividState<unknown>;
    _targetpropertychain?: string[];
    Destroy: () => void;
    Destroying: Signal;
};
export declare function IsStatePropertyValue(Input: unknown): Input is StatePropertyValue;
export declare function GetPropertyStateValueFromPropertyChain(InputObject: unknown, PropertyChain: string[]): unknown;
export declare function createStateFrom<T>(ObserveListener: ObserveListener, CallState: true): VividState<T>;
export declare function createStateFrom<T>(ObserveListener: ObserveListener): VividState<T>;
/**
 *
 * @param State - Is reused internally, the State isn't destroyed with the element - So be sure to cleanup your states where you initially created them!
 */
export declare function createStateFrom<T>(State: State<T>): VividState<T>;
/**
 * @param CallState Will immediately () Call the state within its scope, this should be used if you're passing the State as a prop to a Vivid Component but you're outside of an Element or Scope.
 */
export declare function createStateFrom<T>(State: State<T>, CallState: true): T;
export declare function createState<T>(defaultValue: T, _internal_spring?: {
    damping?: number;
    frequency?: number;
}, _internal_usePseudoState?: State<T>): LuaTuple<[VividState<T>, VividSetState<T>, State<T>]>;
