/*
    Typed with ❤️ @mekstuff
    15/07/2025 20:08:03
*/

/* TODO: Roblox needs to add more support to PluginActions so we can let users customize the key to be held natively.

import { Constants } from "Core/Constants/Constants";
import { GetPlugin } from "./GetPlugin";
import { createCleanup, createEffect } from "@mekstuff-rbxts/vivid";
import { setPluginActionsRuntimeEntries } from "Contexts/PluginActionsContexts";

export function SetupPluginActions() {
	createEffect(() => {
		const HoverDetectionEnabledAction = GetPlugin().CreatePluginAction(
			tostring(math.random()),
			`${Constants.PluginDisplayName} Hover Detection Toggle`,
			"This key shortcut will need to be pressed for hover detection to work during runtime.",
			Constants.PluginDisplayIcon,
			true,
		);

		setPluginActionsRuntimeEntries({
			hover_detection_action: HoverDetectionEnabledAction,
		});

		createCleanup(() => {
			setPluginActionsRuntimeEntries(undefined);
			HoverDetectionEnabledAction.Destroy();
		});
	});
}
*/
