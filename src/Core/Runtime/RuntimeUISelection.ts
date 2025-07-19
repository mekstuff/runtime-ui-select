/*
    Typed with ❤️ @mekstuff
    05/07/2025 18:37:43
*/

import { createCleanup, createEffect, createScope, use } from "@mekstuff-rbxts/vivid";
import { CurrentlyHoveringItems } from "Contexts/RuntimeContexts";
import { SettingsContext } from "Contexts/SettingsContexts";
import { RuntimeContextMenuOpened } from "./RuntimeContextMenu";

const SelectionService = game.GetService("Selection");
const UserInputService = game.GetService("UserInputService");

const RuntimeUISelectionScope = createScope();

createEffect(() => {
	const RuntimeUISelectionEnabled = SettingsContext.AllowUserRuntimeUISelection.get() === true;
	if (RuntimeUISelectionEnabled === false) {
		return;
	}
	const ClickListener = UserInputService.InputBegan.Connect((Input) => {
		if (Input.UserInputType !== Enum.UserInputType.MouseButton1) {
			return;
		}
		if (use(() => RuntimeContextMenuOpened())) {
			return;
		}

		const HoveringItems = use(() => CurrentlyHoveringItems());
		const TargetItem = HoveringItems[0];
		if (TargetItem === undefined) {
			SelectionService.Set([]);
			return;
		}
		if (UserInputService.IsKeyDown(Enum.KeyCode.LeftShift)) {
			const CurrentSelections = SelectionService.Get();
			const IndexOf = CurrentSelections.indexOf(TargetItem);
			if (IndexOf > -1) {
				CurrentSelections.remove(IndexOf);
				SelectionService.Set(CurrentSelections);
			} else {
				SelectionService.Set([...SelectionService.Get(), TargetItem]);
			}
		} else {
			SelectionService.Set([TargetItem]);
		}
	});

	createCleanup(() => {
		ClickListener.Disconnect();
	});
});

RuntimeUISelectionScope.Close();

export = undefined;
