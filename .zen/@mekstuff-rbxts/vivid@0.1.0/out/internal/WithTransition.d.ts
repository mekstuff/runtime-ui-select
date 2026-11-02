export type WithTransitionDef<T = unknown> = {
    _isWithTransition: true;
    _targetValue: T;
    _defaultValue?: T;
    _initialValue?: T;
    _dismountValue?: T;
    _damping?: number;
    _frequency?: number;
};
export declare function IsWithTransitionDef(Input: unknown): Input is WithTransitionDef;
export type WithTransitionProps<V> = {
    Damping?: number;
    Frequency?: number;
    /**
     * The Transition will always return to the default value before animating to the new value.
     */
    DefaultValue?: V;
    /**
     * The initial value/begin value.
     */
    InitialValue?: V;
    /**
     * When dismounted, it gives the component "presence", Allowing it to tranisition to the value provided before being completed destroyed.
     */
    DismountValue?: V;
};
export declare function WithTransition<V>(Value: V, Damping?: number, Frequency?: number, InitialValue?: V, DefaultValue?: V, DismountValue?: V): V;
export declare function WithTransition<V>(Value: V, Props: WithTransitionProps<V>): V;
