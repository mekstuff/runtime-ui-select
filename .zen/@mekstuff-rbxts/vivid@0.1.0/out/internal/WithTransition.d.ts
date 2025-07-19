export type WithTransitionDef<T = unknown> = {
    _isWithTransition: true;
    _targetValue: T;
    _defaultValue?: T;
    _initialValue?: T;
    _damping?: number;
    _frequency?: number;
};
export declare function IsWithTransitionDef(Input: unknown): Input is WithTransitionDef;
type WithTransitionProps<V> = {
    Damping?: number;
    Frequency?: number;
    /**
     * The Transition will always return to the default value before animating to the new value.
     */
    DefaultValue?: V;
    /**
     * THe initial value/begin value.
     */
    InitialValue?: V;
};
export declare function WithTransition<V>(Value: V, Damping?: number, Frequency?: number, DefaultValue?: V): V;
export declare function WithTransition<V>(Value: V, Props: WithTransitionProps<V>): V;
export {};
