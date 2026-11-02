import Vivid, { BoxComponentProps } from "@mekstuff-rbxts/vivid";
import { ButtonProps } from "./Base/index";
export type AccordionProps = ButtonProps & {
    expanded?: boolean;
    expandedIcon?: string;
    collapsedIcon?: string;
} & {
    props?: Partial<{
        AccordionBox: BoxComponentProps;
        AccordionChildrenContainer: Vivid.FC.InstanceProperties<Frame>;
    }>;
};
export declare function Accordion(props: AccordionProps): Instance;
