/**
 * Vivid-next is Vivid with exported functions and methods that use core functionality but makes it easier to develop.
 *
 * e.g., Creation of scopes aren't neccessary when using vivid next functions, e.g. you can create a state any where within your code
 */
import type { StatefulCallback, InstanceAttributes } from "../index";
import { WithTransitionProps } from "../internal/WithTransition";
import { WithSuspense } from "../internal/WithSuspense";
import { Responsive } from "../internal/Responsive";
import { VividSetState, VividSetStateInput, VividState } from "../create/createState";
import { _external_ref } from "../create/createRef";
import { SlotProps } from "../create/createSlot";
import { Spring, State } from "@mekstuff-rbxts/core";
import { createSwitch } from "../conditionals/createSwitch";
import { createConditional } from "../conditionals/createConditional";
import { Motion } from "../functions/Motion";
export type VividNextState<T> = (update?: VividSetStateInput<T> | T) => T;
export declare function element<T extends keyof CreatableInstances>(Element: T, Props?: InstanceAttributes<CreatableInstances[T]>, ...children: unknown[]): CreatableInstances[T];
export declare function element<T extends Callback>(Render: T, Props?: Parameters<T>[0]): ReturnType<T>;
export declare function element(Element: StatefulCallback<unknown>, Props?: unknown): unknown;
/**
 * Similar to `createRef` but doesn't require to be directly in a scope.
 */
export declare function ref<T = Instance, NonNullable extends boolean = false>(): _external_ref<T, NonNullable>;
/**
 * Similar to `createSlot` but doesn't require to be directly in a scope.
 */
export declare function slot(props: SlotProps): never;
/**
 * Similar to `createCleanup` but doesn't require to be directly in a scope.
 */
export declare function cleanup(Callback: Callback): void;
/**
 * Similar to `createState` but doesn't require to be directly in a scope.
 *
 * Also gives you the ability to update states directly with the `VividState` instead of using the `VividSetState`.
 */
export declare function state<T>(defaultValue: T): LuaTuple<[VividNextState<T>, VividSetState<T>, State<T>]>;
/**
 * Similar to `createSpring` but doesn't require to be directly in a scope.
 *
 * Also gives you the ability to update states directly with the `VividState` instead of using the `VividSetState`.
 */
export declare function spring<T>(defaultValue: T, damping?: number, frequency?: number): LuaTuple<[VividNextState<T>, VividSetState<T>, Spring<T>]>;
/**
 * Similar to `createEffect` but doesn't require to be directly in a scope.
 */
export declare function effect<T>(callback: () => T): T extends void ? void : VividState<T>;
/**
 * Similar to `createSwitch` but doesn't require to be directly in a scope.
 */
export declare function vswitch(...args: Parameters<typeof createSwitch>): ReturnType<typeof createSwitch>;
/**
 * Similar to `createConditional` but doesn't require to be directly in a scope.
 */
export declare function condition(...args: Parameters<typeof createConditional>): ReturnType<typeof createConditional>;
export declare function transition<V>(Value: V, Damping?: number, Frequency?: number, InitialValue?: V, DefaultValue?: V): V;
export declare function transition<V>(Value: V, Props: WithTransitionProps<V>): V;
/**
 * Similar to `Motion` but doesn't require to be directly in a scope.
 */
export declare function motion(...args: Parameters<typeof Motion>): ReturnType<typeof Motion>;
declare const fragment: Callback;
export { WithSuspense as suspense, Responsive as responsive, fragment };
