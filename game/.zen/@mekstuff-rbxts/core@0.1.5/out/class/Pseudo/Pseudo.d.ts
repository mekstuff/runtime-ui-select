import { Servant } from "../../class/Servant/Servant";
import { PseudoNext } from "./PseudoNext";
declare global {
    type UnknownArray = {
        [key: string]: unknown;
    };
}
type usePropertyEffectCleanupfunc = (isDestroying?: boolean) => void;
export type usePropertyEffectCleanup = usePropertyEffectCleanupfunc | Servant | Promise<unknown> | RBXScriptConnection | LuaTuple<unknown[]> | void;
export type PseudoDevDefs = {
    get: (targetItem: string | number) => unknown;
    has: (targetItem: unknown) => boolean;
    set: (targetItem: string | number, targetValue: unknown) => void;
    insert: (item: unknown) => void;
    [key: string | number | symbol]: unknown;
    _internal_runtime_debug_info: {
        creationTimestamp: number;
    };
} & UnknownArray;
export type CreatableReferenceInstanceType = Instance | keyof CreatableInstances | (() => Instance);
export type ObserveCallback = () => usePropertyEffectCleanup;
export type ObserveDependency = string | ObserveListener;
export type ObserveDependencies = ObserveDependency[];
export type ObserveListener = {
    _pseudo: Pseudo;
    _deps: ObserveDependencies;
};
type Pseudo<T extends object | unknown = unknown, _REF extends Instance = Folder> = PseudoNext<T, _REF>;
declare const Pseudo: import("./PseudoNext").PseudoNextConstructor;
export { Pseudo };
/**
 * Core class of pseudo objects.
 *
 * -
 * NOTE: If your class has possible `undefined` values, Make sure to initialize those values with `undefined` so
 * Pseudo can capture them.
 * If you fail to make Pseudo capture undefined values, whenever you try to index these values you
 * will get an error.
 *
 *```ts
 * class MyClass = {
 * 	DemonstrationNil: number | undefined = undefined; //will be captured.
 * 	DemonstrationNil2: number | undefined; //will not be captured.
 * }
 *```
 * -
 * NOTE: If you want your Pseudo's `ReferenceInstance` to be parented, you must add (you might want to include `Name` aswell):
 *
 * ```ts
 * class MyClass extends Pseudo {
 * 	constructor(){
 * 		super("MyClass");
 * 		useMapping(["Parent"], [this.GetRef()])
 * 	}
 * }
 * ```
 */
/**
 * TODO: usePropertyEffectWrap doesn't get cleanedup!
 * Core if PowerHorseEngine "Pseudo" components
 *
 * Some stuff to note:
 * * If a Pseudo has a property that will initially be undefined, you need to make it "undefined" so rbxts compiles it.
 * * For undefined properties directly in the Pseudo Class like "Parent" ( Not Properties that will be inherited ), We need to manually call
 * the __newindex method on it initially since the Pseudo will not know the property exists and will be considered not a member when attempting to index.
 *
 */
