import Vivid from "@mekstuff-rbxts/vivid";
export type ImageProps = Vivid.FC.InstancePropertiesWithChildren<ImageLabel> & {
    props?: Partial<{
        Container: Vivid.FC.InstancePropertiesWithChildren<Frame>;
    }>;
    loading?: Vivid.FC.Render;
    fallback?: Vivid.FC.Render;
};
export declare function Image(props: ImageProps): Instance;
