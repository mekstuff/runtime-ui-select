import Vivid from "../index";
/**
 * A `Frame` with `UIPadding` and `UIGridLayout` support.
 */
export type ContainerComponentProps = Vivid.FC.InstancePropertiesWithChildren<Frame> & {
    /**
     * Padding applied to the created `UIPadding`, *NOT* the Padding of the `UIGridLayout`.
     *
     * - if a `number`, all sides will have the offset of the number provided.
     * - if a `Vector2`, left and right will have values of X, top and bottom will have values of Y.
     * - if a `UDim`, UDim will be applied to all sides.
     * - If an array of UDims, In order: left, top, right, bottom.
     */
    UIPadding?: number | Vector2 | UDim | [UDim, UDim, UDim, UDim];
    /**
     * CellPadding applied to the `UIGridLayout`.
     */
    CellPadding?: UDim2;
    /**
     * CellSize applied to the `UIGridLayout`.
     */
    CellSize?: UDim2;
    FillDirectionMaxCells?: number;
    /**
     * StartCorner applied to the `UIGridLayout`.
     */
    StartCorner?: Enum.StartCorner;
    /**
     * FillDirection applied to the `UIGridLayout`.
     */
    FillDirection?: Enum.FillDirection;
    /**
     * HorizontalAlignment applied to the `UIGridLayout`.
     */
    HorizontalAlignment?: Enum.HorizontalAlignment;
    /**
     * VerticalAlignment applied to the `UIGridLayout`.
     */
    VerticalAlignment?: Enum.VerticalAlignment;
    /**
     * SortOrder applied to the `UIGridLayout`.
     */
    SortOrder?: Enum.SortOrder;
};
export declare function Container(props: ContainerComponentProps): Frame;
