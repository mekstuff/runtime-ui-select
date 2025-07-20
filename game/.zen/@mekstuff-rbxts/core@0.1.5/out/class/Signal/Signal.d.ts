export declare class Signal<params extends Callback = Callback> {
    private Qsig;
    ClassName: string;
    private _dev;
    private _id;
    IsA(Class: string): boolean;
    constructor();
    DisconnectAll(): void;
    Connect(Callback: (...args: Parameters<params>) => ReturnType<params>): RBXScriptConnection;
    ConnectParallel(Callback: (...args: Parameters<params>) => ReturnType<params>): RBXScriptConnection;
    Once(Callback: (...args: Parameters<params>) => ReturnType<params>): RBXScriptConnection;
    Fire(...args: Parameters<params>): void;
    Wait(): LuaTuple<Parameters<params>>;
    Destroy(): undefined;
}
