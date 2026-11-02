import { VividState } from "../create/createState";
type MotionType = "tween" | "spring" | "static";
type motionStatesObject = {
    hovered: boolean;
    clicked: boolean;
    inView: boolean;
};
type MotionDefKeys = "default" | "initial" | "animate" | "dismount" | "whileHovered" | "whileClicked" | "whileInView";
type MotionDefValue<T extends object = {}> = {
    [key: string]: unknown;
};
type MotionDefConfig = {
    type?: MotionType;
    /**
     * The instance will not be updated, This is useful in cases where you want to apply the motion yourself using the MotionObject that is returned.
     */
    readonly?: boolean;
    /**
     * Damping for spring if type is `spring`.
     */
    damping?: number;
    /**
     * Frequency for spring if type is `spring`.
     */
    frequency?: number;
};
type MotionDef<T extends object = {}> = {
    [k in MotionDefKeys]?: MotionDefValue<T>;
};
type MotionObject<T extends object> = {
    [k in keyof T]: T[k] extends {
        value: any;
        config: any;
    } ? T[k]["value"] : T[k];
};
/**
 * Animate components easily.
 */
export declare function Motion<T extends object = {}>(motion: MotionDef<T> | (() => MotionDef<T>), config?: MotionDefConfig): {
    props: VividState<Partial<MotionObject<T>>>;
    states: VividState<motionStatesObject>;
};
export {};
