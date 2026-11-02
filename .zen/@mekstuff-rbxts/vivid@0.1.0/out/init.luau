-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local exports = {}
--[[
	
		Typed with ❤️ @mekstuff
		29/12/2024 19:51:36
	
]]
local createSlotInternal = TS.import(script, script, "create", "createSlot").createSlot
local _createState = TS.import(script, script, "create", "createState")
local createStateInternal = _createState.createState
local createStateFromInternal = _createState.createStateFrom
local createSpringInternal = TS.import(script, script, "create", "createSpring").createSpring
local createEffectInternal = TS.import(script, script, "create", "createEffect").createEffect
local createRootInternal = TS.import(script, script, "create", "createRoot").createRoot
local _createScope = TS.import(script, script, "create", "createScope")
local createScopeInternal = _createScope.createScope
local clearScopesInternal = _createScope.clearScopes
local _createElement = TS.import(script, script, "create", "createElement")
local createElementInternal = _createElement.createElement
local ResolveChildren = _createElement.ResolveChildren
local createCleanupInternal = TS.import(script, script, "create", "createCleanup").createCleanup
local createEffectBoundaryInternal = TS.import(script, script, "create", "createEffectBoundary").createEffectBoundary
local createAnimationInternal = TS.import(script, script, "create", "createAnimation").createAnimation
local createRefInternal = TS.import(script, script, "create", "createRef").createRef
local useInternal = TS.import(script, script, "use", "use").use
local createConditionalInternal = TS.import(script, script, "conditionals", "createConditional").createConditional
local createSwitchInternal = TS.import(script, script, "conditionals", "createSwitch").createSwitch
local createSuspenseInternal = TS.import(script, script, "conditionals", "createSuspense").createSuspense
local createPromiseSuspenseInternal = TS.import(script, script, "conditionals", "createSuspense").createPromiseSuspense
local onMountInternal = TS.import(script, script, "lifecycles", "onMount").onMount
local onDismountInternal = TS.import(script, script, "lifecycles", "onDismount").onDismount
local onWillMountInternal = TS.import(script, script, "lifecycles", "onWillMount").onWillMount
local onWillDismountInternal = TS.import(script, script, "lifecycles", "onWillDismount").onWillDismount
local forEachInternal = TS.import(script, script, "functions", "forEach").forEach
local _jsx = TS.import(script, script, "jsx", "jsx")
local JSX_ForEach = _jsx.JSX_ForEach
local JSX_Show = _jsx.JSX_Show
local JSX_Switch = _jsx.JSX_Switch
local JSX_SwitchCase = _jsx.JSX_SwitchCase
local JSX_Suspense = _jsx.JSX_Suspense
local JSX_Portal = _jsx.JSX_Portal
local JSX_Slot = _jsx.JSX_Slot
local _FragmentIdentifier_ = TS.import(script, script, "internal", "Fragment")._FragmentIdentifier_
local UILabsStoryAdapter = TS.import(script, script, "story-adapters", "ui-labs").UILabsStoryAdapter
local _Nodes = TS.import(script, script, "nodes", "Nodes")
local AddActiveNode = _Nodes.AddActiveNode
local CompareElementNode = _Nodes.CompareElementNode
local CreateElementNode = _Nodes.CreateElementNode
local GetLatestActiveNode = _Nodes.GetLatestActiveNode
local RemoveActiveNode = _Nodes.RemoveActiveNode
local RemoveElementNode = _Nodes.RemoveElementNode
local ZIndexLayerInternal = TS.import(script, script, "components", "ZIndexLayer").ZIndexLayer
local BoxInternal = TS.import(script, script, "components", "Box").Box
local ContainerInternal = TS.import(script, script, "components", "Container").Container
local InfiniteScrollingFrameInternal = TS.import(script, script, "components", "InfiniteScrollingFrame").InfiniteScrollingFrame
local ResponsiveInternal = TS.import(script, script, "internal", "Responsive").Responsive
local WithTransitionInternal = TS.import(script, script, "internal", "WithTransition").WithTransition
local WithSuspenseInternal = TS.import(script, script, "internal", "WithSuspense").WithSuspense
local useResponsiveInternal = TS.import(script, script, "hooks", "useResponsive").useResponsive
local EMPTY_ONWILLDISMOUNTFUNC = function()
	return nil
end
local animationPresenceInternal = function()
	return onWillDismountInternal(EMPTY_ONWILLDISMOUNTFUNC)
end
--[[
	* Given an object `T`, returns a unioned type of all non-readonly property names.
	 *
	 * Sourced from React
	 
]]
--[[
	*
	 * Sourced from React
	 
]]
--[[
	*
	 * Sourced from React
	 
]]
--[[
	*
	 * Sourced from React
	 
]]
--[[
	*
	 * Sourced from React
	 
]]
-- type CoreProperties<T> = T extends Instance
-- 	? CoreInstancePropertiesWithChildren<T>
-- 	: { [P in WritablePropertyNames<T>]?: T[P] | (() => T[P]) } & { children?: any };
--[[
	*
	 * Returns an object with the current Enum.StudioStyleGuideColor (Only available in plugins)
	 
]]
--[[
	
	function GetStudioStyleGuideColorsInternal(): StudioStyleGuideColors {
		const StyleGuideColors: StudioStyleGuideColors = {} as StudioStyleGuideColors;
		Enum.StudioStyleGuideColor.GetEnumItems().forEach((GuideColor) => {
			StyleGuideColors[GuideColor.Name] = (settings().Studio as unknown as { Theme: StudioTheme }).Theme.GetColor(
				GuideColor,
			);
		});
		return StyleGuideColors;
	}
	
]]
local Vivid = {}
do
	local _container = Vivid
	local createSlot = createSlotInternal
	_container.createSlot = createSlot
	local createState = createStateInternal
	_container.createState = createState
	local createStateFrom = createStateFromInternal
	_container.createStateFrom = createStateFrom
	local createSpring = createSpringInternal
	_container.createSpring = createSpring
	local createEffect = createEffectInternal
	_container.createEffect = createEffect
	local createRoot = createRootInternal
	_container.createRoot = createRoot
	local createScope = createScopeInternal
	_container.createScope = createScope
	local clearScopes = clearScopesInternal
	_container.clearScopes = clearScopes
	local createElement = createElementInternal
	_container.createElement = createElement
	local createCleanup = createCleanupInternal
	_container.createCleanup = createCleanup
	local createEffectBoundary = createEffectBoundaryInternal
	_container.createEffectBoundary = createEffectBoundary
	local createRef = createRefInternal
	_container.createRef = createRef
	local use = useInternal
	_container.use = use
	local createConditional = createConditionalInternal
	_container.createConditional = createConditional
	local createSwitch = createSwitchInternal
	_container.createSwitch = createSwitch
	local createSuspense = createSuspenseInternal
	_container.createSuspense = createSuspense
	local createPromiseSuspense = createPromiseSuspenseInternal
	_container.createPromiseSuspense = createPromiseSuspense
	local onMount = onMountInternal
	_container.onMount = onMount
	local onDismount = onDismountInternal
	_container.onDismount = onDismount
	local onWillMount = onWillMountInternal
	_container.onWillMount = onWillMount
	local onWillDismount = onWillDismountInternal
	_container.onWillDismount = onWillDismount
	local forEach = forEachInternal
	_container.forEach = forEach
	local Box = BoxInternal
	_container.Box = Box
	local Container = ContainerInternal
	_container.Container = Container
	local ZIndexLayer = ZIndexLayerInternal
	_container.ZIndexLayer = ZIndexLayer
	local InfiniteScrollingFrame = InfiniteScrollingFrameInternal
	_container.InfiniteScrollingFrame = InfiniteScrollingFrame
	local Responsive = ResponsiveInternal
	_container.Responsive = Responsive
	local WithTransition = WithTransitionInternal
	_container.WithTransition = WithTransition
	local WithSuspense = WithSuspenseInternal
	_container.WithSuspense = WithSuspense
	local useResponsive = useResponsiveInternal
	_container.useResponsive = useResponsive
	local AnimationPresence = animationPresenceInternal
	_container.AnimationPresence = AnimationPresence
	local Fragment = _FragmentIdentifier_
	_container.Fragment = Fragment
	-- export const createFragment = _FragmentIdentifier_ as unknown as FC.Render<Record<string, any>>; //eslint-disable-line
	-- used for Fragments that have control of direct child to control props being applied.
	local createElementPropertyProcessor = "__internal_createElement_property__processor__"
	_container.createElementPropertyProcessor = createElementPropertyProcessor
	--[[
		
			export const createFragmentPropertyProcessor = "__internal_fragment_property__processor__";
			export type createFragmentPropertyProcessorProps = {
				Key: unknown;
				Value: unknown;
				Object: Instance;
				ApplyProperty: Callback;
			};
			
	]]
	-- Minimal Studio Theme
	-- export const GetStudioStyleGuideColors = GetStudioStyleGuideColorsInternal;
	-- JSX Export
	local Show = JSX_Show
	_container.Show = Show
	local For = JSX_ForEach
	_container.For = For
	local Switch = JSX_Switch
	_container.Switch = Switch
	local SwitchCase = JSX_SwitchCase
	_container.SwitchCase = SwitchCase
	local Suspense = JSX_Suspense
	_container.Suspense = Suspense
	local Portal = JSX_Portal
	_container.Portal = Portal
	local Slot = JSX_Slot
	_container.Slot = Slot
	local Animate = createAnimationInternal
	_container.Animate = Animate
	-- utils
	local Utils = {
		ResolveChildren = ResolveChildren,
		AddActiveNode = AddActiveNode,
		RemoveActiveNode = RemoveActiveNode,
		GetLatestActiveNode = GetLatestActiveNode,
		CreateElementNode = CreateElementNode,
		RemoveElementNode = RemoveElementNode,
		CompareElementNode = CompareElementNode,
	}
	_container.Utils = Utils
	-- FC
	-- export namespace FC {
	-- 	type childrenObj<Q extends ChildNodeType> = {
	-- 		//eslint-disable-next-line
	-- 		children?: ChildNode<any, Q>;
	-- 	};
	-- 	export type ComponentMountProps = {
	-- 		onMount?: () => void;
	-- 		onWillMount?: () => void;
	-- 		onDismount?: () => void;
	-- 		onWillDismount?: () => void;
	-- 	};
	-- 	export type createElementPropRef<T extends Instance> = {
	-- 		ref?: _external_ref<T>;
	-- 		forwardRef?: _external_ref<T>;
	-- 	};
	-- 	export type createElementAttributes = {
	-- 		/**
	-- 		 * Attribute Values can be one depth level states.
	-- 		 */
	-- 		attributes?: Record<string, AttributeValue>;
	-- 	};
	-- 	export type createElementTags = {
	-- 		tags?: string[];
	-- 	};
	-- 	export type ChildNode<T extends Instance = Instance, Q extends ChildNodeType = "list"> = Q extends "list"
	-- 		? FC.Node<T>[]
	-- 		: Q extends "dictionary"
	-- 			? Record<string, FC.Node<T>>
	-- 			: T[] | Record<string, FC.Node<T>>;
	-- 	export type Node<I extends Instance = Instance> = I;
	-- 	export type InstanceProps<T extends Instance | keyof Instances> = T extends keyof Instances
	-- 		? {
	-- 				[k in keyof Instances[T]]: Instances[T][k];
	-- 			}
	-- 		: {
	-- 				[k in keyof T]: T[k];
	-- 			};
	-- 	export type Props<
	-- 		T extends keyof Instances | Instance | Callback | object = object,
	-- 		Q extends ChildNodeType = "dictionary",
	-- 	> = (T extends Callback
	-- 		? createElementPropDefs<Parameters<T>[0]> | object
	-- 		: T extends keyof Instances
	-- 			? Partial<createElementPropDefs<InstanceProps<T>>>
	-- 			: T extends Instance
	-- 				? Partial<createElementPropDefs<InstanceProps<T>>>
	-- 				: createElementPropDefs<T>) &
	-- 		createElementPropRef<
	-- 			T extends Instance ? T : T extends keyof CreatableInstances ? CreatableInstances[T] : Instance
	-- 		> &
	-- 		// createElementPropRef<T extends keyof Instances ? Instances[T] : T extends Instance ? T : Instance> &
	-- 		childrenObj<Q> &
	-- 		createElementAttributes &
	-- 		createElementTags &
	-- 		ComponentMountProps;
	-- 	export type Render<props = unknown, I extends Instance = Instance, propsdef = false> = propsdef extends false
	-- 		? (props?: props, children?: unknown) => I
	-- 		: (props: props, children: unknown) => I;
	-- }
	-- JSX
	-- export function Show<T>(props: {
	-- 	when: () => unknown;
	-- 	children: () => Instance | void;
	-- 	fallback?: () => Instance | void;
	-- }) {}
end
for _k, _v in TS.import(script, script, "create", "createSlot") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createState") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createSpring") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createEffect") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createScope") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createRoot") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createElement") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createCleanup") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createEffectBoundary") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createAnimation") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "create", "createRef") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "use", "use") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "conditionals", "createConditional") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "conditionals", "createSwitch") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "conditionals", "createSuspense") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "lifecycles", "onMount") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "lifecycles", "onDismount") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "lifecycles", "onWillMount") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "lifecycles", "onWillDismount") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "components", "Box") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "components", "Container") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "components", "ZIndexLayer") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "components", "InfiniteScrollingFrame") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "internal", "Responsive") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "internal", "WithTransition") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "internal", "WithSuspense") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "hooks", "useResponsive") or {} do
	exports[_k] = _v
end
-- export { GetStudioStyleGuideColorsInternal as GetStudioStyleGuideColors };
local StoryAdapters = {
	UILabs = UILabsStoryAdapter,
}
for _k, _v in TS.import(script, script, "functions", "forEach") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "vivid-next") or {} do
	exports[_k] = _v
end
local default = Vivid
exports.AnimationPresence = animationPresenceInternal
exports.Vivid = Vivid
exports.Show = JSX_Show
exports.For = JSX_ForEach
exports.Switch = JSX_Switch
exports.Case = JSX_SwitchCase
exports.Suspense = JSX_Suspense
exports.Portal = JSX_Portal
exports.Slot = JSX_Slot
exports.createRef = createRefInternal
exports.Animate = createAnimationInternal
exports.StoryAdapters = StoryAdapters
exports.default = default
return exports
