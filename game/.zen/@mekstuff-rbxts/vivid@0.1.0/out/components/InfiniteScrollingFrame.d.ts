import Vivid from "..";
import { forEachProps } from "../functions/forEach";
type fetchItems<T> = (start: number, total: number) => T[];
export type InfiniteScrollingFrameProps<T, UID> = Vivid.FC.Props<ScrollingFrame> & {
    /**
     * Function for fetching the items
     */
    fetchItems: fetchItems<T>;
    /**
     * Function for rendering an item
     */
    renderItem: NonNullable<forEachProps<T[], Instance, UID>["children"]>;
    /**
     * Used to generate unique id for each item, this means that if the content unqiue id already exists, the component will not be recreated, only the index will update.
     */
    uniqueIdExtractor?: forEachProps<T[], Instance, UID>["uniqueIdExtractor"];
    /**
     * Override the default behavior when the the scrolling frame is scrolled to the bottom
     */
    onScrollFetch?: (index: number, fetchItems: fetchItems<T>) => void;
    /**
     * How much items will be fetched, defaults to `10`.
     */
    fetchTotal?: number;
    /**
     * How many items will be fetched on the first requests, defaults to `fetchTotal`
     */
    initialFetchTotal?: number;
    /**
     * This is used as a "reset" property. When the fetchId is changed, the current index will be reset back to 0 and all existing rendered items will be removed.
     */
    fetchId?: string;
};
export declare function InfiniteScrollingFrame<T, UID>(props: InfiniteScrollingFrameProps<T, UID>): ScrollingFrame;
export {};
