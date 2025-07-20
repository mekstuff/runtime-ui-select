declare global {
    namespace PHe {
        interface Pseudos {
            Collector: Collector;
        }
    }
}
import { Pseudo, Servant } from "@mekstuff-rbxts/core";
/***/
declare class Collector extends Pseudo {
    /**
     * Gets all items with the tag
     */
    GetTagged(TagName: string): (Instance | Pseudo)[];
    /**
     * Add collection service tag to Instance/Pseudo
     */
    Tag(instance: Instance | Pseudo | undefined, TagName: string): void;
    /**
     * Remove collection service tag from Instance/Pseudo
     */
    RemoveTag(instance: Instance | Pseudo, TagName: string): void;
    /**
     * Bind to a collection service tag
     */
    Bind<T extends Instance | Pseudo = Instance | Pseudo>(TagName: string, Callback: (Object: T, BindServant: Servant) => unknown): Servant;
    constructor();
}
declare const COLLECTOR: Collector;
export default COLLECTOR;
export { COLLECTOR as Collector };
