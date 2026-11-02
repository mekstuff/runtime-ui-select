type CreateEffectCallbackParam = Callback & {
    /**
     * If you need to run logic inside of a createEffect function that normally cannot
     * be executed inside of a createEffect, you can end the effect early by calling this function.
     *
     * This can solve cases where you experience "Attempted to createScope inside createEffect" or similar.
     */
    exit: () => void;
    cleanup: () => void;
};
/**
 * If any State is called within your `Callback`, it will rerun your `Callback` anytime that state changes.
 *
 * If you return a value from the first run of your effect, your effect will be "stateful", meaning it will return a `State` that you can
 * use like any other State. Whenever your effect runs again, the State will be updated to whatever value is returned.
 *
 * @param [AccurateDependencyExecution=false] By default, if your effect has multiple dependencies, You callback will execute only at the end of the frame and will only run once. Meaning if two dependent states
 * changes at the same time, instead of running the function twice, it will run only once with the updated values being correct. However, setting this to true will make the function
 * run twice, where the first function will see state1 be up to date but state2 not technically "updated", then another execution where both states are "updated".
 *
 */
export declare function createEffect<T>(Callback: (effect: CreateEffectCallbackParam) => T, DefaultValue?: T, AccurateDependencyExecution?: boolean): T extends void ? void : () => T;
export {};
