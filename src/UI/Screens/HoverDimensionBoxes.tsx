/*
    Typed with ❤️ @mekstuff
    02/07/2025 23:48:09
*/

const Players = game.GetService("Players");

import Vivid, { Case, createCleanup, createEffect, createState, For, Switch } from "@mekstuff-rbxts/vivid";
import { Theme } from "@mekstuff-rbxts/vivid-ui";
import { CurrentlyHoveringItems } from "Contexts/RuntimeContexts";
import { SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { DimensionBox } from "UI/Components/DimensionBox";

export function HoverDimensionBoxes() {
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
				return SettingsContext.ShowDimensionsOnHover.get() === true;
			})()}
		>
			<Case condition={true}>
				{() => (
					<screengui
						Name={`${Constants.PluginDisplayName} - HoverDimensions`}
						Parent={PlayerGui}
						DisplayOrder={Constants.ScreenGuiDisplayOrderLimit - 1}
						ResetOnSpawn={false}
					>
						<For
							each={CurrentlyHoveringItems()}
							uniqueIdExtractor={(item) => item}
							children={(props) => (
								<DimensionBox
									Adornee={props}
									ViewportSize={ViewportSize()}
									PrimaryColor={Theme().MainButton}
									BackgroundColor={Theme().MainBackground}
									ShowAbsoluteSize={SettingsContext.ShowAbsoluteSizeOnHover.get()}
									ShowAbsolutePosition={SettingsContext.ShowAbsolutePositionOnHover.get()}
									ShowInstanceName={SettingsContext.ShowInstanceNameOnHover.get()}
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
