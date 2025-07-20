import Vivid from "@mekstuff-rbxts/vivid";
export type SpinnerProps = {
    enabled: boolean;
    speed?: number;
    props?: Partial<{
        Container: Vivid.FC.Props<Frame>;
        UIAspectRatioConstraint: Vivid.FC.Props<UIAspectRatioConstraint>;
    }>;
} & Vivid.FC.Props<ImageLabel>;
export declare function Spinner(props: SpinnerProps): Instance;
