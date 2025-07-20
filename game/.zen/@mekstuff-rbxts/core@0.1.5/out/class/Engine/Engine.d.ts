export declare const Engine: {
    /**
     * Initializes the server
     */
    InitServer: () => void;
    FetchReplicatedStorage: (TargetSubContainer?: string) => Instance;
    FetchWorkspaceStorage: (TargetSubContainer?: string) => Instance;
    FetchServerStorage: (TargetSubContainer?: string) => Instance;
    FetchServerScripts: (TargetSubContainer?: string) => Instance;
};
