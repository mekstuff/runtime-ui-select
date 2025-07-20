import Vivid from "..";
export type forEachProps<T, I extends Instance, UID> = {
    each: T;
    children?: (props: T extends unknown[] ? T[number] : T[keyof T], index: Vivid.StatefulCallback<T extends unknown[] ? number : keyof T>, uid: UID) => I;
    /**
     * Used to generate unique id for each item, this means that if the content unqiue id already exists, the component will not be recreated, only the index will update.
     */
    uniqueIdExtractor?: (item: T extends unknown[] ? T[number] : T[keyof T], key: T extends unknown[] ? number : keyof T) => UID;
};
export declare function forEach<T, I extends Instance, UID>(props: forEachProps<T, I, UID>): Vivid.StatefulCallback<I>;
