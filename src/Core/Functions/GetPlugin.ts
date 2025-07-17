/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:19:24
*/

import { use } from "@mekstuff-rbxts/vivid";
import { PluginContexts } from "Contexts/PluginContexts";

export function GetPlugin(): Plugin {
	const Plugin = use(() => PluginContexts().plugin);
	assert(Plugin, "Plugin not assigned.");

	return Plugin;
}
