import Vivid from "..";
import { GetElementNode } from "../nodes/Nodes";
/**
 * @param toObject the returned object will be the Proxy version of `props`. meaning you can loop and do anything to this table like you would a normal table.
 */
export declare function withProps<T extends object>(props: T, toObject?: boolean): T;
/**
 *
 * Used to parent children to a Target Instance.
 *
 * @param targetChildren
 * @param Target
 * @param ParentCreateElementNode
 */
export declare function ResolveChildren(targetChildren: unknown, Target: Instance, ParentCreateElementNode?: ReturnType<typeof GetElementNode>): void;
export declare function createElement<E extends Callback | keyof CreatableInstances | Vivid.StatefulCallback<unknown>>(Element: E, targetProps?: Vivid.FC.Props<E>, _children_defined?: unknown, ...jsx_children: unknown[]): E extends Callback ? ReturnType<E> : E extends keyof Instances ? Instances[E] : never;
