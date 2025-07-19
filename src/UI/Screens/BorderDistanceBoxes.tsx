/*
    Typed with ❤️ @mekstuff
    18/07/2025 17:49:16
*/

const Players = game.GetService("Players");

import Vivid, { Case, createEffect, For, Switch } from "@mekstuff-rbxts/vivid";
import { Theme } from "@mekstuff-rbxts/vivid-ui";
import { CurrentlyHoveringItems } from "Contexts/RuntimeContexts";
import { SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { BorderDistanceBox } from "UI/Components/BorderDistanceBox";

export function BorderDistanceBoxes() {
	const PlayerGui = Players.LocalPlayer.WaitForChild("PlayerGui");
	return (
		<Switch
			conditional={createEffect(() => {
				return SettingsContext.ShowBorderBoxesOnHover.get() === true;
			})()}
		>
			<Case condition={true}>
				{() => (
					<screengui
						Name={`${Constants.PluginDisplayName} - BorderDistances`}
						Parent={PlayerGui}
						DisplayOrder={997}
						ResetOnSpawn={false}
					>
						<For
							each={CurrentlyHoveringItems()}
							children={(props) => (
								<BorderDistanceBox
									Adornee={props}
									BackgroundColor3={Theme().MainButton}
									TextColor3={Theme().MainText}
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
