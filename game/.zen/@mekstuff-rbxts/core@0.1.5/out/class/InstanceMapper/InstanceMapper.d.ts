import { Pseudo } from "../Pseudo/Pseudo";
declare class InstanceMap extends Pseudo {
    constructor(MappedItem: {
        [key: string]: unknown;
    });
}
type InstanceMapReturn<K extends keyof CreatableInstances> = InstanceMap & CreatableInstances[K] & {
    [key: string]: any;
};
export declare class InstanceMapperClass extends Pseudo {
    New<K extends keyof CreatableInstances>(Instance: K): InstanceMapReturn<K>;
    New<K extends keyof CreatableInstances>(Instance: Instance): InstanceMapReturn<K>;
    constructor();
}
declare const InstanceMapper: InstanceMapperClass;
export { InstanceMapper };
export default InstanceMapper;
