import Vivid, { BoxComponentProps } from "@mekstuff-rbxts/vivid";
import { ButtonProps } from "./Base";
export type AccordionProps = ButtonProps & Vivid.FC.Props<{
    expanded?: boolean;
    expandedIcon?: string;
    collapsedIcon?: string;
}> & {
    props?: Partial<{
        AccordionBox: BoxComponentProps;
        AccordionChildrenContainer: Vivid.FC.Props<Frame>;
    }>;
};
export declare function Accordion(props: AccordionProps): Instance;
