import Vivid from "@mekstuff-rbxts/vivid";
export type TabRoute = {
    _history: string[];
    _defaultRoute?: string;
    clearHistory: () => void;
    jumpTo: (target: string, ignoreHistory?: boolean) => boolean;
    goBack: () => boolean;
};
export declare function createTabRoute(defaultRoute?: string): TabRoute;
export type TabType = "default" | "drawer";
export type TabProp = {
    name?: string;
    content?: Vivid.FC.Render;
};
export type Tabs = Record<string, TabProp>;
export type TabsProps = {
    route: TabRoute;
    tabs: Tabs;
};
export declare function Tabs(props: TabsProps): Instance;
