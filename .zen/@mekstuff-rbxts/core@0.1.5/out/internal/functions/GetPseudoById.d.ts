import { Pseudo } from "../../class/Pseudo/Pseudo";
declare const PseudoCollector: {
    [key: string]: Pseudo;
};
/**
 * Searches for the pseudo by the id, if no pseudo matches the id then returns nil
 */
export declare function GetPseudoById(PseudoId: string): Pseudo | undefined;
export { PseudoCollector };
