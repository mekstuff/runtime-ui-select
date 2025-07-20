type UA = {
    [key: string]: unknown;
};
declare function DeepCopyTable(t: UA): UA;
declare function ReconcileTable(target: UA, template: UA, mutate?: boolean): {} | undefined;
export { ReconcileTable, DeepCopyTable };
