import Vivid from "../index";
export type SwitchStatement<T = Instance> = (Condition: Vivid.StatefulCallback<unknown>, Truthy?: Vivid.FC.Render, Falsy?: Vivid.FC.Render) => SwitchStatementReturn<T>;
export type SwitchStatementReturn<T = Instance> = Vivid.StatefulCallback<T> & {
    Case: (Condition: unknown | (() => boolean), Truthy: Vivid.FC.Render) => SwitchStatementReturn<T>;
    Default: (Default: Vivid.FC.Render) => SwitchStatementReturn<T>;
};
/**
 *
 * @param Condition A State
 * @param Truthy Optional shorthand for if Condition is true.
 * @param Falsy Optional shorthand for if Condition is false.
 * @returns SwitchStatementReturn, Can be called and used as a State and/or be a chainable object that contains `.Case` and `.Default`.
 *
 * e.g. createSwitch(State).Case(true, ...).Case(false, ...).Case(1, ...)
 *
 * Cases can also use functions that expect a boolean to be returned to specify if the condition is met. The Condition value will be passed as the first param.
 *
 * e.g. createSwitch(State: boolean).Case((State: boolean) => State === true, ...) --> Whenever "State" is true, the Case will be rendered.
 * e.g. createSwitch(State: number).Case((State: boolean) => State > 1, ...) --> Whenever "State" is more than 1, the Case will be rendered.
 *
 * For jsx:
 *
 * <Switch condition={...}>
 * 	<Case>() => createElement(...)</Case>
 * </Switch>
 */
export declare function createSwitch<T = Instance>(Condition: unknown, Truthy?: Vivid.FC.Render, Falsy?: Vivid.FC.Render): SwitchStatementReturn<T>;
