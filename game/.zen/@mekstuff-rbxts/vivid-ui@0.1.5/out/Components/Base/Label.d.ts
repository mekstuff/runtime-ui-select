import Vivid from "@mekstuff-rbxts/vivid";
import { InputProps } from "./Input";
export type LabelEditTextProvider = {
    callbackAsync: () => string | undefined;
    onCallback?: (...args: Parameters<LabelEditTextProvider["callbackAsync"]>) => ReturnType<LabelEditTextProvider["callbackAsync"]>;
};
export type LabelProps = Vivid.FC.Props<TextButton> & {
    editText?: LabelEditTextProvider;
    editTextInputProps?: InputProps;
};
export declare function CreateLabelEditTextCallback(): LabelEditTextProvider;
export declare function Label(props: LabelProps): Instance;
