export type BorderDistanceLineProps = {
    PrimaryColor: Color3;
    TextColor: Color3;
    BorderColor: Color3;
    Position: "Left" | "Top" | "Right" | "Bottom";
    Length: number;
    Thickness: number;
};
export declare function BorderDistanceLine(props: BorderDistanceLineProps): Instance;
