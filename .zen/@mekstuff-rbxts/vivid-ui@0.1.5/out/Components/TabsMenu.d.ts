import Vivid from "@mekstuff-rbxts/vivid";
export type TabsMenuTab = {
    title: string;
    content: Vivid.FC.Render;
    icon?: string;
};
export declare function TabsMenu(props: {
    tabs: (TabsMenuTab | undefined)[];
    highlighterColor3?: Color3;
}): Instance;
