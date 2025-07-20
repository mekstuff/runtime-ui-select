import Vivid from "..";
/**
 * A `Frame` with `UIPadding` and `UIListLayout` support.
 */
export type BoxComponentProps = Vivid.FC.Props<Frame> & {
    /**
     * Applied respectively to the `HorizontalAlignment` and `VerticalAlignment`, If the `alignment` provided exists on both Vertical and Horizontal axis, it will be applied to both. e.g. `Center`.
     */
    alignment?: Enum.VerticalAlignment | Enum.HorizontalAlignment | undefined;
    /**
     * Padding applied to the created `UIPadding`, *NOT* the Padding of the `UIListLayout`.
     *
     * - if a `number`, all sides will have the offset of the number provided.
     * - if a `Vector2`, left and right will have values of X, top and bottom will have values of Y.
     * - if a `UDim`, UDim will be applied to all sides.
     * - If an array of UDims, In order: left, top, right, bottom.
     */
    UIPadding?: number | Vector2 | UDim | [UDim, UDim, UDim, UDim];
    /**
     * HorizontalFlex applied to the `UIListLayout`.
     */
    HorizontalFlex?: Enum.UIFlexAlignment;
    /**
     * ItemLineAlignment applied to the `UIListLayout`.
     */
    ItemLineAlignment?: Enum.ItemLineAlignment;
    Padding?: UDim;
    /**
     * VerticalFlex applied to the `UIListLayout`.
     */
    VerticalFlex?: Enum.UIFlexAlignment;
    /**
     * Wraps applied to the `UIListLayout`.
     */
    Wraps?: boolean;
    /**
     * FillDirection applied to the `UIListLayout`.
     */
    FillDirection?: Enum.FillDirection;
    /**
     * HorizontalAlignment applied to the `UIListLayout`.
     */
    HorizontalAlignment?: Enum.HorizontalAlignment;
    /**
     * VerticalAlignment applied to the `UIListLayout`.
     */
    VerticalAlignment?: Enum.VerticalAlignment;
    /**
     * SortOrder applied to the `UIListLayout`.
     */
    SortOrder?: Enum.SortOrder;
};
export declare function Box(props: BoxComponentProps): Frame;
