import Vivid, { InstanceAttributes } from "../index";
import { Servant } from "@mekstuff-rbxts/core";
import { GetElementNode } from "../nodes/Nodes";
export declare const CreateElementFragmentRenderFunction: () => never;
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
export declare function ResolveChildren(targetChildren: unknown, inputTarget: Instance, ParentCreateElementNode: ReturnType<typeof GetElementNode> | undefined, UseRootServant: Servant | undefined): void;
export declare function createElement<T extends keyof CreatableInstances>(Element: T, Props?: InstanceAttributes<CreatableInstances[T]>, ...children: unknown[]): CreatableInstances[T];
export declare function createElement<T extends Callback>(Render: T, Props?: Parameters<T>[0], ...children: unknown[]): ReturnType<T>;
export declare function createElement(Element: Vivid.StatefulCallback<unknown>, Props?: unknown, ...children: unknown[]): unknown;
