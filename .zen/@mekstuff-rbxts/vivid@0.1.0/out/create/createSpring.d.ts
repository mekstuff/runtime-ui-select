import { Spring } from "@mekstuff-rbxts/core";
import { VividSetState, VividState } from "./createState";
export declare function createSpring<T>(defaultValue: T, damping?: number, frequency?: number): LuaTuple<[VividState<T>, VividSetState<T>, Spring<T>]>;
