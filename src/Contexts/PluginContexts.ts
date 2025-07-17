/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:20:02
*/

import { createScope, createState } from "@mekstuff-rbxts/vivid";

const PluginContextsScope = createScope();

export const [PluginContexts, setPluginContexts] = createState<{ plugin: Plugin }>({} as never);

PluginContextsScope.Close();
