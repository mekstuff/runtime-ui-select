import Vivid from "../index";
export declare function createPromiseSuspense(SuspensePromise: () => Promise<unknown>, Content: Vivid.FC.Render, Loading?: Vivid.FC.Render, Err?: Vivid.FC.Render, 
/**
 * If the Promise is resolved and the result is a boolean, if true, it will be considered "Resolved", if false,it will be considered "Stale" (Stale means nothing is rendered.)
 */
BooleanConsidered?: boolean): import("./createSwitch").SwitchStatementReturn<Instance>;
/**
 * Will call the Content function inside a Promise, Note that the Content function is not wrapped in a createElement(). It is called directly inside the Promise.
 *
 * This allows you to have yielding code inside of an element
 *
 * e.g.
 *
 * return <> <Suspense>{() => task.wait(1); return <textlabel/>}</Suspense> </>
 */
export declare function createSuspense(Content: Vivid.FC.Render, Loading?: Vivid.FC.Render, Err?: Vivid.FC.Render): import("./createSwitch").SwitchStatementReturn<Instance>;
