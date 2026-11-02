import Vivid from "../index";
import { ReturnControls } from "@rbxts/ui-labs/src/ControlTypings/Typing";
import { InferGenericProps } from "@rbxts/ui-labs";
export type StoryState<T = unknown> = {
    value: Vivid.StatefulCallback<T>;
    setter: Vivid.StateSetter<T>;
};
type UILabsStoryAdapterConfig = {
    /**
     * Wraps your component inside a box that is scaled `.95,.95`, anchored `.5,.5`, positioned `.5,.5` and Centers content with `UIListLayout`.
     */
    wrapInBox?: boolean;
};
export declare function UILabsStoryAdapter<T extends ReturnControls>(controls: T, render: Vivid.FC.Render<T & InferGenericProps<never> & {
    setCleanupFunction: (callback: Callback) => void;
}, Instance, true>, config?: UILabsStoryAdapterConfig): {
    controls: T;
    render: (uilabsprops: InferGenericProps<typeof controls>) => () => void;
};
export {};
