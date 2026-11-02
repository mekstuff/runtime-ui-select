import { Dispatch, SetStateAction } from "@rbxts/react";
import { Pseudo } from "../../../class/Pseudo/Pseudo";
type SetStateActionRequiredState<S> = S | ((prevState: Required<S>) => S);
/**
 * When using setState on bulk properties, the values will be set on the start of the next frame!
 */
export declare function usePseudo<T extends Pseudo, Q extends {
    [K in keyof T as string]?: K;
}>(pseudo: T, property: Q): [
    {
        [K in keyof Q]: Q[K] extends keyof T ? T[Q[K]] : never;
    },
    Dispatch<SetStateActionRequiredState<{
        [K in keyof Q]?: Q[K] extends keyof T ? T[Q[K]] : never;
    }>>
];
export declare function usePseudo<T extends Pseudo, P extends keyof T>(pseudo: T, property: P): [T[P], Dispatch<SetStateAction<T[P]>>];
export {};
