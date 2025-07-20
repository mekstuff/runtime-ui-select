/*
    Typed with ❤️ @mekstuff
    05/07/2025 18:21:04
*/

const Players = game.GetService("Players");

import Vivid, { Case, createEffect, For, Switch } from "@mekstuff-rbxts/vivid";
import { Theme } from "@mekstuff-rbxts/vivid-ui";
import { CurrentlySelectedItems } from "Contexts/RuntimeContexts";
import { SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { DimensionBox } from "UI/Components/DimensionBox";

export function SelectedDimensionBoxes() {
	const PlayerGui = Players.LocalPlayer.WaitForChild("PlayerGui");
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
