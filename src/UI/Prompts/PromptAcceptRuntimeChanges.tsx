/*
    Typed with ❤️ @mekstuff
    15/07/2025 18:58:29
*/

import { PromptTextOption } from "./PromptTextOption";

export function PromptAcceptRuntimeChanges(onOption: (option: boolean) => void) {
	return PromptTextOption({
		title: "Save Changes",
		body: "You have made some settings changes during runtime, Do you wish to save them?",
		onOption: onOption,
	});
}
