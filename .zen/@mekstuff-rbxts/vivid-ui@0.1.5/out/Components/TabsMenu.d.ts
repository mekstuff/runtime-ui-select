export type TabsMenuTab = {
    Title: string;
    Content: Instance;
    Icon?: string;
};
export declare function TabsMenu(props: {
    tabs: (TabsMenuTab | undefined)[];
    highlighterColor3?: Color3;
}): Instance;
