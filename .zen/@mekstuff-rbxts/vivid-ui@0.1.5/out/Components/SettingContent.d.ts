import Vivid from "@mekstuff-rbxts/vivid";
import { LabelProps } from "./Base/index";
export type SettingContentSeparatorProps = {
    Visible?: boolean;
    LayoutOrder?: number;
    separatorText: string;
    props?: {
        Container?: Vivid.FC.InstanceProperties<Frame>;
        UIListLayout?: Vivid.FC.InstanceProperties<UIListLayout>;
        Label?: LabelProps;
        ContentSeparatorLine?: Vivid.FC.InstanceProperties<Frame>;
    };
};
export declare function SettingContentSeparator(props: SettingContentSeparatorProps): Instance;
export type SettingContentProps = {
    titleText: string;
    hideSplitter?: boolean;
    scaleDistribution?: number;
    LayoutOrder?: number;
    Visible?: boolean;
    children?: unknown;
    props?: {
        Container?: Vivid.FC.InstanceProperties<Frame>;
        ContentContainer?: Vivid.FC.InstanceProperties<Frame>;
        UIListLayout?: Vivid.FC.InstanceProperties<UIListLayout>;
        UIPadding?: Vivid.FC.InstanceProperties<UIPadding>;
        TitleLabel?: LabelProps;
        ContentSeparatorLine?: Vivid.FC.InstanceProperties<Frame>;
        RightContainer?: Vivid.FC.InstanceProperties<Frame>;
        RightContainerUIListLayout?: Vivid.FC.InstanceProperties<UIListLayout>;
    };
};
export declare function SettingContent(props: SettingContentProps): Instance;
