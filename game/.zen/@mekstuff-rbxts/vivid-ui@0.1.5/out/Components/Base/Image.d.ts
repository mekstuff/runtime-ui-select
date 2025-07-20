import Vivid from "@mekstuff-rbxts/vivid";
export type ImageProps = Vivid.FC.Props<ImageLabel> & {
    props?: Partial<{
        Container: Vivid.FC.Props<Frame>;
    }>;
    loading?: Vivid.FC.Render;
    fallback?: Vivid.FC.Render;
};
export declare function Image(props: ImageProps): Instance;
