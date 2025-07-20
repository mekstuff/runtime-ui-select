import Vivid from "@mekstuff-rbxts/vivid";
import { InferGenericProps } from "@rbxts/ui-labs";
import { ReturnControls } from "@rbxts/ui-labs/src/ControlTypings/Typing";
export declare function CreateStory<T extends ReturnControls>(controls: T, render: Vivid.FC.Render<T & InferGenericProps<never> & {
    setCleanupFunction: (callback: Callback) => void;
}, Instance, true>): {
    controls: T;
    render: (uilabsprops: InferGenericProps<T>) => () => void;
};
