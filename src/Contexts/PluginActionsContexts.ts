/*
    Typed with ❤️ @mekstuff
    15/07/2025 20:27:25
*/

/* TODO: Roblox needs to add more support to PluginActions so we can let users customize the key to be held natively.

import { Servant } from "@mekstuff-rbxts/core";
import { createCleanup, createEffect, createScope, createState } from "@mekstuff-rbxts/vivid";
import { GetIsRunningSession } from "Core/Functions/GetUsageContext";
const PluginActionsContextsScope = createScope();

export const [PluginActionsContexts, setPluginActionsContexts] = createState<{
	hover_detection_action_active: boolean;
}>({
	hover_detection_action_active: false,
});

export const [PluginActionsRuntimeEntries, setPluginActionsRuntimeEntries] = createState<
	| {
			hover_detection_action: PluginAction;
	  }
	| undefined
>(undefined);

if (GetIsRunningSession() === true) {
	createEffect(() => {
		const Actions = PluginActionsRuntimeEntries();
		if (Actions === undefined) {
			return;
		}
		const ListenerServant = new Servant();
		for (const [actionName, actionInstance] of pairs(Actions)) {
			ListenerServant.Keep(
				actionInstance.Triggered.Connect(() => {
					print("triggered");
					setPluginActionsContexts((old) => {
						const targetActiveKey = `${actionName}_active` as keyof typeof old;
						print("toggling", targetActiveKey);
						old[targetActiveKey] = !old;
						return { ...old };
					});
				}),
			);
		}
		createCleanup(() => {
			ListenerServant.Destroy();
		});
	});
}

PluginActionsContextsScope.Close();
*/
