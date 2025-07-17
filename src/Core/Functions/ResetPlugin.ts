/*
    Typed with ❤️ @mekstuff
    16/07/2025 22:38:36
*/

import { SetSettingsContextDefault } from "Contexts/SettingsContexts";
import { PromptTextOption } from "UI/Prompts/PromptTextOption";
import { ClearSettingsModule } from "./SettingsModuleController";

export function ResetPluginToDefault() {
	PromptTextOption({
		title: "Reset",
		body: "Are you sure you want to reset the current settings to the default?",
		onOption: (option) => {
			if (option === false) {
				return;
			}
			SetSettingsContextDefault();
			SetSettingsContextDefault(); // x2 for settings that dependent of other settings.
			ClearSettingsModule();
		},
	});
}
