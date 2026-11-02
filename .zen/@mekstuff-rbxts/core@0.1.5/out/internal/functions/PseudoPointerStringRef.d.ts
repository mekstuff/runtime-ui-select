import { Pseudo } from "../../class/Pseudo/Pseudo";
/**
 *
 * Gets the PseudoId from a unique pointer string ref.
 *
 * @param PointerStringRef
 */
export declare function GetPseudoIdFromPointerStringRef(PointerStringRef: string): string | undefined;
/**
 *
 * Gets a Pseudo from a unique pointer string ref.
 *
 * @param PointerStringRef
 */
export declare function GetPseudoFromPointerStringRef(PointerStringRef: string): Pseudo | undefined;
/**
 *
 * String points to a Pseudo
 *
 * @param PointerStringRef
 */
export declare function CreatePseudoPointerStringRef(Pseudo: unknown): string | undefined;
