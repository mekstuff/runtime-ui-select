import Vivid from "@mekstuff-rbxts/vivid";
export type SpinnerProps = {
    enabled: boolean;
    speed?: number;
    props?: Partial<{
        Container: Vivid.FC.InstanceProperties<Frame>;
        UIAspectRatioConstraint: Vivid.FC.InstanceProperties<UIAspectRatioConstraint>;
    }>;
} & Vivid.FC.InstanceProperties<ImageLabel>;
export declare function Spinner(props: SpinnerProps): Instance;
