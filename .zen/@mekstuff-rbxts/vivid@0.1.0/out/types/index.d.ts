import { VividSetState, VividState } from "../create/createState";
import { _external_ref } from "../create/createRef";
import { InstanceAttributes } from "./react";

// export type Props<TInstance extends Instance | Callback | object | keyof Instances = object> =
// 	TInstance extends Instance
// 		? InstanceAttributes<TInstance>
// 		: TInstance extends Callback
// 			? void
// 			: TInstance extends object
// 				? void
// 				: TInstance extends keyof Instances
// 					? ""
// 					: void;
// export interface PropertiesWithChildren {
// 	children?: unknown;
// }

// export type childrenObj<Q extends ChildNodeType> = {
// 	//eslint-disable-next-line
// 	children?: ChildNode<any, Q>;
// };

// export type ChildNodeType = "list" | "dictionary" | "listdict";

// export type ComponentMountProps = {
// 	onMount?: () => void;
// 	onWillMount?: () => void;
// 	onDismount?: () => void;
// 	onWillDismount?: () => void;
// };

// export type createElementPropDefs<T> = {
// 	[k in keyof T]: SupportedComponentProperty<T[k]>;
// };
// export type createElementPropRef<T extends Instance> = {
// 	ref?: _external_ref<T>;
// 	forwardRef?: _external_ref<T>;
// };
// export type createElementAttributes = {
// 	/**
// 	 * Attribute Values can be one depth level states.
// 	 */
// 	attributes?: Record<string, AttributeValue>;
// };
// export type createElementTags = {
// 	tags?: string[];
// };

// export type FunctionalPropertyValue<T> = () => T extends true ? boolean : T extends false ? boolean : T; // To combat "boolean is not assignable to true | false"
// export type SupportedComponentProperty<T> = T extends RBXScriptSignal
// 	? (Ref: any, ...args: T extends RBXScriptSignal<infer X> ? Parameters<X> : never) => void // eslint-disable-line
// 	: T | FunctionalPropertyValue<T>;

// export type ChildNode<T extends Instance = Instance, Q extends ChildNodeType = "list"> = Q extends "list"
// 	? Node<T>[]
// 	: Q extends "dictionary"
// 		? Record<string, Node<T>>
// 		: T[] | Record<string, Node<T>>;
// export type Node<I extends Instance = Instance> = I;

// export type InstanceProps<T extends Instance | keyof Instances> = T extends keyof Instances
// 	? {
// 			[k in keyof Instances[T]]: Instances[T][k];
// 		}
// 	: {
// 			[k in keyof T]: T[k];
// 		};

// export type Props<
// 	T extends keyof Instances | Instance | Callback | object = object,
// 	Q extends ChildNodeType = "dictionary",
// > = (T extends Callback
// 	? createElementPropDefs<Parameters<T>[0]> | object
// 	: T extends keyof Instances
// 		? Partial<createElementPropDefs<InstanceProps<T>>>
// 		: T extends Instance
// 			? Partial<createElementPropDefs<InstanceProps<T>>>
// 			: createElementPropDefs<T>) &
// 	createElementPropRef<
// 		T extends Instance ? T : T extends keyof CreatableInstances ? CreatableInstances[T] : Instance
// 	> &
// 	// createElementPropRef<T extends keyof Instances ? Instances[T] : T extends Instance ? T : Instance> &
// 	childrenObj<Q> &
// 	createElementAttributes &
// 	createElementTags &
// 	ComponentMountProps;

// export type Render<props = unknown, I extends Instance = Instance, propsdef = false> = propsdef extends false
// 	? (props?: props, children?: unknown) => I
// 	: (props: props, children: unknown) => I;
