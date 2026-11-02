import Vivid from "../index";
import { VividState } from "../create/createState";
export type ShowProps = {
    condition: VividState<boolean> | (() => boolean);
    children?: Vivid.FC.Render;
};
export declare function Show(props: ShowProps): import("../index").SwitchStatementReturn<Instance>;
