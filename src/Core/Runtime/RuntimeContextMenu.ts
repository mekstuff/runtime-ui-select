/*
    Typed with ❤️ @mekstuff
    17/07/2025 19:33:29
*/

import { createCleanup, createEffect, createScope, createState, use } from "@mekstuff-rbxts/vivid";
import { Icons } from "@mekstuff-rbxts/vivid-ui";
import { CurrentlyHoveringItems, CurrentlyHoveringItemsUnfiltered } from "Contexts/RuntimeContexts";
import { SettingsContext } from "Contexts/SettingsContexts";
import { GetPlugin } from "Core/Functions/GetPlugin";

const Selection = game.GetService("Selection");
const UserInputService = game.GetService("UserInputService");
type PluginActionDef = PluginAction & { Text: string };

const RuntimeContextMenuScope = createScope();

export const [RuntimeContextMenuOpened, setRuntimeContextMenuOpened] = createState(false);

createEffect(() => {
	const RightClickForContextMenu = SettingsContext.RightClickForContextMenu.get() === true;
	if (RightClickForContextMenu === false) {
		return;
	}

	const ContextMenu = GetPlugin().CreatePluginMenu(tostring(math.random()));

	const RightClickListener = UserInputService.InputBegan.Connect((Input) => {
		if (Input.UserInputType !== Enum.UserInputType.MouseButton2) {
			return;
		}
		const HoveringItems = use(() => CurrentlyHoveringItems());
		const HoveringItemsUnfiltered = use(() => CurrentlyHoveringItemsUnfiltered());
		if (HoveringItems.size() <= 0) {
			return;
		}
		const SelectCurrentGuiPluginAction = ContextMenu.AddNewAction(
			tostring(math.random()),
			`Select ${HoveringItems[0].Name}`,
			Icons.fromName("fluency", "outline", "mouse-cursor-click"),
		) as PluginActionDef;
		SelectCurrentGuiPluginAction.Triggered.Connect(() => {
			Selection.Set([HoveringItems[0]]);
		});

		const HideCurrentGuiPluginAction = ContextMenu.AddNewAction(
			tostring(math.random()),
			`Hide ${HoveringItems[0].Name}`,
			Icons.fromName("fluency", "outline", "eye-invisible-dash-iris-pupil"),
		) as PluginActionDef;
		HideCurrentGuiPluginAction.Triggered.Connect(() => {
			HoveringItems[0].Visible = false;
		});

		const SelectCurrentGuiRootScreenGui = ContextMenu.AddNewAction(
			tostring(math.random()),
			`Select Root ScreenGui For ${HoveringItems[0].Name}`,
			Icons.fromName("fluency", "outline", "media-screen-share-broadcast"),
		) as PluginActionDef;
		SelectCurrentGuiRootScreenGui.Triggered.Connect(() => {
			const RootScreenGui = HoveringItems[0].FindFirstAncestorOfClass("ScreenGui");
			if (RootScreenGui === undefined) {
				return;
			}
			Selection.Set([RootScreenGui]);
		});

		const SelectUILayerPluginMenu = GetPlugin().CreatePluginMenu(tostring(math.random()), `Select UI Layer`);
		HoveringItemsUnfiltered.forEach((HoveringItem) => {
			SelectUILayerPluginMenu.AddNewAction(tostring(math.random()), `${HoveringItem.Name}`).Triggered.Connect(
				() => {
					Selection.Set([HoveringItem]);
				},
			);
		});

		ContextMenu.AddMenu(SelectUILayerPluginMenu);

		const SelectAllInstancesHoveredPluginAction = ContextMenu.AddNewAction(
			tostring(math.random()),
			`Select All Hovering GUI's (${HoveringItemsUnfiltered.size()})`,
		) as PluginActionDef;
		SelectAllInstancesHoveredPluginAction.Triggered.Connect(() => {
			Selection.Set(HoveringItemsUnfiltered);
		});

		setRuntimeContextMenuOpened(true);
		ContextMenu.ShowAsync();

		SelectCurrentGuiPluginAction.Destroy();
		HideCurrentGuiPluginAction.Destroy();
		SelectCurrentGuiRootScreenGui.Destroy();
		SelectUILayerPluginMenu.Destroy();
		SelectAllInstancesHoveredPluginAction.Destroy();
		task.delay(0.1, () => {
			setRuntimeContextMenuOpened(false);
		});
	});

	createCleanup(() => {
		RightClickListener.Disconnect();
	});
});

RuntimeContextMenuScope.Close();
