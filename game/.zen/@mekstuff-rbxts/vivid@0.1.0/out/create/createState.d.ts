import { State } from "@mekstuff-rbxts/core";
import { ObserveListener } from "@mekstuff-rbxts/core/out/class/Pseudo/Pseudo";
export type VividState<T> = () => T;
type VividSetStateCallback<T> = (cb: (oldValue: T) => T) => void;
type VividSetStateInput<T> = (newValue: T) => void;
export type VividSetState<T> = VividSetStateCallback<T> & VividSetStateInput<T>;
export type StatePropertyValue = {
    _isstatepropval: boolean;
    _state: State<unknown>;
    _call: VividState<unknown>;
    _targetproperty?: string;
};
export declare function IsStatePropertyValue(Input: unknown): Input is StatePropertyValue;
export declare function createStateFrom<T>(ObserveListener: ObserveListener, CallState: true): VividState<T>;
export declare function createStateFrom<T>(ObserveListener: ObserveListener): VividState<T>;
export declare function createStateFrom<T>(State: State<T>): VividState<T>;
/**
 * @param CallState Will immediately () Call the state within its scope, this should be used if you're passing the State as a prop to a Vivid Component but you're outside of an Element or Scope.
 */
export declare function createStateFrom<T>(State: State<T>, CallState: true): T;
export declare function createState<T>(defaultValue: T, _internal_spring?: {
    damping?: number;
    frequency?: number;
}): LuaTuple<[VividState<T>, VividSetState<T>, State<T>]>;
export {};
