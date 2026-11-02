/*
    Typed with ❤️ @mekstuff
    05/07/2025 18:21:04
*/

const Players = game.GetService("Players");

import Vivid, { Case, createCleanup, createEffect, createState, For, Switch } from "@mekstuff-rbxts/vivid";
import { Theme } from "@mekstuff-rbxts/vivid-ui";
import { CurrentlySelectedItems } from "Contexts/RuntimeContexts";
import { SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { DimensionBox } from "UI/Components/DimensionBox";

export function SelectedDimensionBoxes() {
	const PlayerGui = Players.LocalPlayer.WaitForChild("PlayerGui");
	const [CurrentCamera, setCurrentCamera] = createState<Camera | undefined>(game.Workspace.CurrentCamera);
	const [ViewportSize, setViewportSize] = createState(new Vector2(1920, 1080));

	const CameraChangedListener = game.Workspace.GetPropertyChangedSignal("CurrentCamera").Connect(() => {
		setCurrentCamera(game.Workspace.CurrentCamera);
	});

	createEffect(() => {
		const Camera = CurrentCamera();
		if (Camera === undefined) {
			setViewportSize(new Vector2(1920, 1080));
			return;
		}
		setViewportSize(Camera.ViewportSize);
	});

	createCleanup(() => {
		CameraChangedListener.Disconnect();
	});

	return (
		<Switch
			conditional={createEffect(() => {
				return SettingsContext.ShowDimensionsOnSelected.get() === true;
			})()}
		>
			<Case condition={true}>
				{() => (
					<screengui
						Name={`${Constants.PluginDisplayName} - SelectedDimensions`}
						Parent={PlayerGui}
						DisplayOrder={Constants.ScreenGuiDisplayOrderLimit - 1}
						ResetOnSpawn={false}
					>
						<For
							each={CurrentlySelectedItems()}
							uniqueIdExtractor={(item) => item.GetFullName()}
							children={(props) => (
								<DimensionBox
									Adornee={props}
									ViewportSize={ViewportSize()}
									PrimaryColor={Theme().BrightText}
									BackgroundColor={Theme().MainButton}
									ShowAbsoluteSize={SettingsContext.ShowAbsoluteSizeOnSelected.get()}
									ShowAbsolutePosition={SettingsContext.ShowAbsolutePositionOnSelected.get()}
									ShowInstanceName={SettingsContext.ShowInstanceNameOnSelected.get()}
								/>
							)}
						/>
					</screengui>
				)}
			</Case>
			<Case condition={false}>{() => <></>}</Case>
		</Switch>
	);
}
