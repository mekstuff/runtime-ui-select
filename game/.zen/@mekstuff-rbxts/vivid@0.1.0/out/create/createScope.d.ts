import { Servant } from "@mekstuff-rbxts/core";
import { CreateElementNode } from "../nodes/Nodes";
type Scope = {
    readonly Opened: boolean;
    Close: () => void;
    Destroy: () => void;
    Servant: Servant;
};
/**
 * A scope can be used to bind components/elements to a servant. Any createEffects/Elements
 * created while the scope is Opened will bind to it. Similar to how createEffects and States
 * will bind the createElement
 *
 * @param BoundToElementNode If defined, will return that bounded element node and does not create a seperate Element node for the scope but
 * replaces the servant of the bounded node with the servant of the a new Servant while the scope is opened. When closed, the bounded element node will return
 * to the previous state. When the scope is closed, the bounded element node *WILL NOT* be destroyed.
 * `Close()` does not call `RemoveElementNode` if `BoundToElementNode` is defined.
 */
export declare function createScope(ElementNodeRef?: ReturnType<typeof CreateElementNode>): Scope;
export declare function clearScopes(): void;
export {};
