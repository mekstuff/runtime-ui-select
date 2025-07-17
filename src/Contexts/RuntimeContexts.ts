/*
    Typed with ❤️ @mekstuff
    02/07/2025 23:20:03
*/

import { createCleanup, createEffect, createScope, createState } from "@mekstuff-rbxts/vivid";
import { SettingsContext } from "./SettingsContexts";
import { Tags } from "Core/Constants/Tags";

const Players = game.GetService("Players");
const RunService = game.GetService("RunService");
const GuiService = game.GetService("GuiService");
const UserInputService = game.GetService("UserInputService");

type SelectionServiceType = Selection & { SelectionChanged: RBXScriptSignal };
const SelectionService = game.GetService("Selection") as SelectionServiceType;

const PlayerGui = Players.LocalPlayer.WaitForChild("PlayerGui") as PlayerGui;

const RuntimeContextsScope = createScope();

export const [CurrentlyHoveringItems, setCurrentlyHoveringItems] = createState<GuiObject[]>([]);
export const [CurrentlySelectedItems, setCurrentlySelectedItems] = createState<GuiObject[]>([]);

// Hovering
createEffect(() => {
	if (SettingsContext.HoverDetectionEnabled.get() === false) {
		return;
	}

	let Selections = SelectionService.Get();
	const SelectionChanged = SelectionService.SelectionChanged.Connect(() => {
		Selections = SelectionService.Get();
	});

	// TODO: Detect if UseHoverDetectionActivationKeybind is enabled and only allow hovering if it is on and the key is down.

	const MultiHoverDetectionEnabled = SettingsContext.MultiHoverDetectionEnabled.get();
	const IgnoreTransparentGUIObjects = SettingsContext.IgnoreTransparentGUIObjects.get();
	const UseHoverDetectionActivationKeybind = SettingsContext.UseHoverDetectionActivationKeybind.get();
	const Update = RunService.Heartbeat.Connect(() => {
		if (UseHoverDetectionActivationKeybind === true) {
			if (UserInputService.IsKeyDown(Enum.KeyCode.LeftControl) === false) {
				setCurrentlyHoveringItems((old) => {
					if (old.size() === 0) {
						return old;
					}
					return [];
				});
				return;
			}
		}
		const MouseLocation = UserInputService.GetMouseLocation().sub(new Vector2(0, GuiService.TopbarInset.Height));
		let GuiObjectsAtPosition = PlayerGui.GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y)
			.map((f) => {
				if (f.HasTag(Tags.IgnoreHoverDetection) === true) {
					return;
				}
				if (Selections.indexOf(f) > -1) {
					// return;
				}
				if (IgnoreTransparentGUIObjects === true) {
					if (f.IsA("TextLabel") || f.IsA("TextBox") || f.IsA("TextButton")) {
						if (f.TextTransparency === 1 && f.BackgroundTransparency === 1) {
							return;
						}
					} else if (f.IsA("ImageLabel")) {
						if (f.ImageTransparency === 1) {
							return;
						}
					} else {
						if (f.BackgroundTransparency === 1) {
							return;
						}
					}
				}

				return f;
			})
			.filterUndefined();

		if (MultiHoverDetectionEnabled === false) {
			const Target = GuiObjectsAtPosition[0];
			if (
				Target === undefined
				// || Selections.size() > 0
			) {
				GuiObjectsAtPosition = [];
			} else {
				GuiObjectsAtPosition = [Target];
			}
		}

		setCurrentlyHoveringItems((old) => {
			if (old.size() === 0 && GuiObjectsAtPosition.size() === 0) {
				return old; // no re-render
			}
			let OldAndNewMatches = 0;
			// NOTE: not sure how performant this will be, but it is more performant than having vivid rerender the state even if the same items are being hovered.
			old.forEach((oldItem) => {
				if (GuiObjectsAtPosition.indexOf(oldItem) === -1) {
					return;
				}
				OldAndNewMatches += 1;
			});

			if (OldAndNewMatches === GuiObjectsAtPosition.size() && old.size() === OldAndNewMatches) {
				return old; // no re-render
			}

			return GuiObjectsAtPosition;
		});
	});

	createCleanup(() => {
		setCurrentlyHoveringItems([]);
		SelectionChanged.Disconnect();
		Update.Disconnect();
	});
});

// Selected
createEffect(() => {
	if (SettingsContext.SelectedDetectionEnabled.get() === false) {
		return;
	}

	setCurrentlySelectedItems(
		SelectionService.Get()
			.map((f) => (f.IsA("GuiObject") ? f : undefined))
			.filterUndefined(),
	);
	const Update = SelectionService.SelectionChanged.Connect(() => {
		setCurrentlySelectedItems(
			SelectionService.Get()
				.map((f) => (f.IsA("GuiObject") ? f : undefined))
				.filterUndefined(),
		);
	});

	createCleanup(() => {
		setCurrentlyHoveringItems([]);
		Update.Disconnect();
	});
});

RuntimeContextsScope.Close();
