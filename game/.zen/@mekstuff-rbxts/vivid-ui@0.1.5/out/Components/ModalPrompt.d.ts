import Vivid from "@mekstuff-rbxts/vivid";
import { LabelProps, ModalProps } from "./Base";
export type ModalPromptProps = {
    title?: string;
    body?: string;
    buttons?: Instance[];
    props?: {
        ModalUIPadding?: Vivid.FC.Props<UIPadding>;
        ModalUIListLayout?: Vivid.FC.Props<UIListLayout>;
        TitleLabel?: LabelProps;
        BodyLabel?: LabelProps;
        ButtonsFrame?: Vivid.FC.Props<Frame>;
        ButtonsUIListLayout?: Vivid.FC.Props<UIListLayout>;
    };
} & ModalProps;
export declare function ModalPrompt(props: ModalPromptProps): Instance;
