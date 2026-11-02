import { CheckboxProps, LabelProps } from "./Base/index";
export type LabelledCheckboxProps = {
    checkboxProps: CheckboxProps;
    labelProps?: LabelProps;
    onClick?: () => void;
};
export declare function LabelledCheckbox(props: LabelledCheckboxProps): Instance;
