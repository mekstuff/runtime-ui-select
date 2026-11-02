import Vivid from "../index";
import { State } from "@mekstuff-rbxts/core";
type AnimationParamProps = Record<string, unknown>;
type CustomAnimationPropDef = {
    _states: State<boolean>[];
    _props: AnimationParamProps;
};
export type createAnimationProps = {
    custom?: CustomAnimationPropDef[];
    /**
     * Will revert to these properties when no state is applied. default or animate will be
     * fallback tables with default getting first say.
     *
     * default will also run in place of animate for onMount if animate is not defined.
     */
    default?: AnimationParamProps;
    /**
     * onWillMount
     */
    initial?: AnimationParamProps;
    /**
     * onMount
     */
    animate?: AnimationParamProps;
    /**
     * onWillDismount
     */
    exit?: AnimationParamProps;
    /**
     * Whenever the object is being hovered, only works for GUI objects.
     */
    whileHovering?: AnimationParamProps;
    /**
     *
     */
    whileInView?: AnimationParamProps;
    /**
     * Whenever the object is being clicked, only works for Buttons.
     */
    whileClicking?: AnimationParamProps;
    /**
     * Set the damping and frequency of springs for specific properties.
     *
     * damping defaults to 1.
     * frequency defaults to 2.
     */
    springs?: Record<string, {
        damping?: number;
        frequency?: number;
    }>;
    children?: Vivid.FC.Render;
};
declare function createAnimationCall(props: createAnimationProps): Instance;
declare const define_custom_animation_state: (StateConditions: boolean | boolean[], Props: AnimationParamProps) => CustomAnimationPropDef;
export declare const createAnimation: typeof createAnimationCall & {
    custom: typeof define_custom_animation_state;
};
export {};
