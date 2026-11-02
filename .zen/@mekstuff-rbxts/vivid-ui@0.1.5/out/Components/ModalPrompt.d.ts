import Vivid from "@mekstuff-rbxts/vivid";
import { LabelProps, ModalProps } from "./Base/index";
export type ModalPromptProps = {
    title?: string;
    body?: string;
    buttons?: Instance[];
    props?: {
        ModalUIPadding?: Vivid.FC.InstanceProperties<UIPadding>;
        ModalUIListLayout?: Vivid.FC.InstanceProperties<UIListLayout>;
        TitleLabel?: LabelProps;
        BodyLabel?: LabelProps;
        ButtonsFrame?: Vivid.FC.InstanceProperties<Frame>;
        ButtonsUIListLayout?: Vivid.FC.InstanceProperties<UIListLayout>;
    };
} & ModalProps;
export declare function ModalPrompt(props: ModalPromptProps): Instance;
