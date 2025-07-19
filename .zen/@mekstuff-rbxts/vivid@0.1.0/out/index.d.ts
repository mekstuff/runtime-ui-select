import { createSlot as createSlotInternal } from "./create/createSlot";
import { createState as createStateInternal, createStateFrom as createStateFromInternal, VividSetState, VividState } from "./create/createState";
import { createSpring as createSpringInternal } from "./create/createSpring";
import { createEffect as createEffectInternal } from "./create/createEffect";
import { createRoot as createRootInternal } from "./create/createRoot";
import { createScope as createScopeInternal, clearScopes as clearScopesInternal } from "./create/createScope";
import { createElement as createElementInternal, ResolveChildren } from "./create/createElement";
import { createCleanup as createCleanupInternal } from "./create/createCleanup";
import { createEffectBoundary as createEffectBoundaryInternal } from "./create/createEffectBoundary";
import { createAnimation as createAnimationInternal } from "./create/createAnimation";
import { createRef as createRefInternal, _external_ref } from "./create/createRef";
import { use as useInternal } from "./use/use";
import { createConditional as createConditionalInternal } from "./conditionals/createConditional";
import { createSwitch as createSwitchInternal } from "./conditionals/createSwitch";
import { createSuspense as createSuspenseInternal } from "./conditionals/createSuspense";
import { createPromiseSuspense as createPromiseSuspenseInternal } from "./conditionals/createSuspense";
import { onMount as onMountInternal } from "./lifecycles/onMount";
import { onDismount as onDismountInternal } from "./lifecycles/onDismount";
import { onWillMount as onWillMountInternal } from "./lifecycles/onWillMount";
import { onWillDismount as onWillDismountInternal } from "./lifecycles/onWillDismount";
import { forEach as forEachInternal } from "./functions/forEach";
import { JSX_ForEach, JSX_Show, JSX_Switch, JSX_SwitchCase, JSX_Suspense, JSX_Portal, JSX_Slot } from "./jsx/jsx";
import { UILabsStoryAdapter } from "./story-adapters/ui-labs";
import { AddActiveNode, CompareElementNode, CreateElementNode, GetLatestActiveNode, RemoveActiveNode, RemoveElementNode } from "./nodes/Nodes";
import { ZIndexLayer as ZIndexLayerInternal } from "./components/ZIndexLayer";
import { Box as BoxInternal } from "./components/Box";
import { Container as ContainerInternal } from "./components/Container";
import { InfiniteScrollingFrame as InfiniteScrollingFrameInternal } from "./components/InfiniteScrollingFrame";
import { Responsive as ResponsiveInternal } from "./internal/Responsive";
import { WithTransition as WithTransitionInternal } from "./internal/WithTransition";
import { useResponsive as useResponsiveInternal } from "./hooks/useResponsive";
type ChildNodeType = "list" | "dictionary" | "listdict";
type StudioStyleGuideColors = {
    [k in Enum.StudioStyleGuideColor as k["Name"]]: Color3;
};
/**
 * Returns an object with the current Enum.StudioStyleGuideColor (Only available in plugins)
 */
declare function GetStudioStyleGuideColorsInternal(): StudioStyleGuideColors;
export declare namespace Vivid {
    const createSlot: typeof createSlotInternal;
    const createState: typeof createStateInternal;
    const createStateFrom: typeof createStateFromInternal;
    const createSpring: typeof createSpringInternal;
    const createEffect: typeof createEffectInternal;
    const createRoot: typeof createRootInternal;
    const createScope: typeof createScopeInternal;
    const clearScopes: typeof clearScopesInternal;
    const createElement: typeof createElementInternal;
    const createCleanup: typeof createCleanupInternal;
    const createEffectBoundary: typeof createEffectBoundaryInternal;
    const createRef: typeof createRefInternal;
    const use: typeof useInternal;
    const createConditional: typeof createConditionalInternal;
    const createSwitch: typeof createSwitchInternal;
    const createSuspense: typeof createSuspenseInternal;
    const createPromiseSuspense: typeof createPromiseSuspenseInternal;
    const onMount: typeof onMountInternal;
    const onDismount: typeof onDismountInternal;
    const onWillMount: typeof onWillMountInternal;
    const onWillDismount: typeof onWillDismountInternal;
    const forEach: typeof forEachInternal;
    const Box: typeof BoxInternal;
    const Container: typeof ContainerInternal;
    const ZIndexLayer: typeof ZIndexLayerInternal;
    const InfiniteScrollingFrame: typeof InfiniteScrollingFrameInternal;
    const Responsive: typeof ResponsiveInternal;
    const WithTransition: typeof WithTransitionInternal;
    const useResponsive: typeof useResponsiveInternal;
    type StatefulCallback<T> = VividState<T>;
    type StateSetter<T> = VividSetState<T>;
    const Fragment: FC.Render<Record<string, any>>;
    const createFragment: FC.Render<Record<string, any>>;
    const createElementPropertyProcessor: any;
    type createElementPropertyProcessorProps = {
        Key: string;
        Value: unknown;
        Target: Instance;
        ApplyProperty: (Target: Instance, key: string, value: unknown, ParentCreateElementNode?: ReturnType<typeof CreateElementNode>) => void;
        ParentCreateElementNode?: ReturnType<typeof CreateElementNode>;
    };
    const GetStudioStyleGuideColors: typeof GetStudioStyleGuideColorsInternal;
    const Show: typeof JSX_Show;
    const For: typeof JSX_ForEach;
    const Switch: typeof JSX_Switch;
    const SwitchCase: typeof JSX_SwitchCase;
    const Suspense: typeof JSX_Suspense;
    const Portal: typeof JSX_Portal;
    const Slot: typeof JSX_Slot;
    const Animate: ((props: import("./create/createAnimation").createAnimationProps) => Instance) & {
        custom: (StateConditions: boolean | boolean[], Props: {
            [x: string]: unknown;
        }) => {
            _states: import("@mekstuff-rbxts/core").State<boolean>[];
            _props: {
                [x: string]: unknown;
            };
        };
    };
    const Utils: {
        ResolveChildren: typeof ResolveChildren;
        AddActiveNode: typeof AddActiveNode;
        RemoveActiveNode: typeof RemoveActiveNode;
        GetLatestActiveNode: typeof GetLatestActiveNode;
        CreateElementNode: typeof CreateElementNode;
        RemoveElementNode: typeof RemoveElementNode;
        CompareElementNode: typeof CompareElementNode;
    };
    namespace FC {
        type childrenObj<Q extends ChildNodeType> = {
            children?: ChildNode<any, Q>;
        };
        export type ComponentMountProps = {
            onMount?: () => void;
            onWillMount?: () => void;
            onDismount?: () => void;
            onWillDismount?: () => void;
        };
        export type createElementPropDefs<T> = {
            [k in keyof T]: SupportedComponentProperty<T[k]>;
        };
        export type createElementPropRef<T extends Instance> = {
            ref?: _external_ref<T>;
            forwardRef?: _external_ref<T>;
        };
        export type createElementAttributes = {
            /**
             * Attribute Values can be one depth level states.
             */
            attributes?: Record<string, AttributeValue>;
        };
        export type createElementTags = {
            tags?: string[];
        };
        export type FunctionalPropertyValue<T> = () => T extends true ? boolean : T extends false ? boolean : T;
        export type SupportedComponentProperty<T> = T extends RBXScriptSignal ? (Ref: any, ...args: T extends RBXScriptSignal<infer X> ? Parameters<X> : never) => void : T | FC.FunctionalPropertyValue<T>;
        export type ChildNode<T extends Instance = Instance, Q extends ChildNodeType = "list"> = Q extends "list" ? FC.Node<T>[] : Q extends "dictionary" ? Record<string, FC.Node<T>> : T[] | Record<string, FC.Node<T>>;
        export type Node<I extends Instance = Instance> = I;
        export type InstanceProps<T extends Instance | keyof Instances> = T extends keyof Instances ? {
            [k in keyof Instances[T]]: Instances[T][k];
        } : {
            [k in keyof T]: T[k];
        };
        export type Props<T extends keyof Instances | Instance | Callback | object = object, Q extends ChildNodeType = "dictionary"> = (T extends Callback ? createElementPropDefs<Parameters<T>[0]> | object : T extends keyof Instances ? Partial<createElementPropDefs<InstanceProps<T>>> : T extends Instance ? Partial<createElementPropDefs<InstanceProps<T>>> : createElementPropDefs<T>) & createElementPropRef<T extends keyof Instances ? Instances[T] : T extends Instance ? T : Instance> & childrenObj<Q> & createElementAttributes & createElementTags & ComponentMountProps;
        export type Render<props = unknown, I extends Instance = Instance, propsdef = false> = propsdef extends false ? (props?: props, children?: unknown) => I : (props: props, children: unknown) => I;
        export {};
    }
    namespace JSX {
        type Element = Instance;
        type IntrinsicElements = {
            [k in keyof CreatableInstances as Lowercase<k>]: Vivid.FC.createElementPropDefs<Partial<Vivid.FC.InstanceProps<CreatableInstances[k]>>> & Vivid.FC.ComponentMountProps & Vivid.FC.createElementPropRef<CreatableInstances[k]> & Vivid.FC.createElementAttributes & Vivid.FC.createElementTags;
        };
    }
}
export * from "./create/createSlot";
export * from "./create/createState";
export * from "./create/createSpring";
export * from "./create/createEffect";
export * from "./create/createScope";
export * from "./create/createRoot";
export * from "./create/createElement";
export * from "./create/createCleanup";
export * from "./create/createEffectBoundary";
export * from "./create/createAnimation";
export * from "./create/createRef";
export * from "./use/use";
export * from "./conditionals/createConditional";
export * from "./conditionals/createSwitch";
export * from "./conditionals/createSuspense";
export * from "./lifecycles/onMount";
export * from "./lifecycles/onDismount";
export * from "./lifecycles/onWillMount";
export * from "./lifecycles/onWillDismount";
export * from "./components/Box";
export * from "./components/Container";
export * from "./components/ZIndexLayer";
export * from "./components/InfiniteScrollingFrame";
export * from "./internal/Responsive";
export * from "./internal/WithTransition";
export * from "./hooks/useResponsive";
export { StudioStyleGuideColors };
export { GetStudioStyleGuideColorsInternal as GetStudioStyleGuideColors };
export { JSX_Show as Show };
export { JSX_ForEach as For };
export { JSX_Switch as Switch };
export { JSX_SwitchCase as Case };
export { JSX_Suspense as Suspense };
export { JSX_Portal as Portal };
export { JSX_Slot as Slot };
export { createAnimationInternal as Animate };
export { createRefInternal as createRef };
declare const StoryAdapters: {
    UILabs: typeof UILabsStoryAdapter;
};
export { StoryAdapters };
export * from "./functions/forEach";
export default Vivid;
