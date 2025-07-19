import Vivid from "..";
import { forEachProps } from "../functions/forEach";
import { SlotProps } from "../create/createSlot";
import { PortalProps } from "../create/createPortal";
export declare function JSX_Slot(props: SlotProps): never;
export declare function JSX_Portal(props: PortalProps): never;
export declare function JSX_Show(props: {
    when: boolean;
    children?: Vivid.FC.Render;
    loading?: Vivid.FC.Render;
    fallback?: Vivid.FC.Render;
}): Instance;
export declare function JSX_ForEach<T, I extends Instance, UID>(props: forEachProps<T, I, UID>): Instance;
export declare function JSX_Suspense(props: {
    children?: Vivid.FC.Render;
    loading?: Vivid.FC.Render;
    fallback?: Vivid.FC.Render;
}): Instance;
export declare function JSX_Switch(props: {
    conditional: unknown;
    children?: unknown;
}): Instance;
export declare function JSX_SwitchCase(props: {
    condition: unknown;
    children?: Vivid.FC.Render;
}): never;
