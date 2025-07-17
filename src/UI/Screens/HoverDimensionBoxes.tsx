/*
    Typed with ❤️ @mekstuff
    02/07/2025 23:48:09
*/

const Players = game.GetService("Players");

import Vivid, { Case, createEffect, For, Switch } from "@mekstuff-rbxts/vivid";
import { Theme } from "@mekstuff-rbxts/vivid-ui";
import { CurrentlyHoveringItems } from "Contexts/RuntimeContexts";
import { SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { DimensionBox } from "UI/Components/DimensionBox";

export function HoverDimensionBoxes() {
	const PlayerGui = Players.LocalPlayer.WaitForChild("PlayerGui");
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
						DisplayOrder={998}
						ResetOnSpawn={false}
					>
						<For
							each={CurrentlyHoveringItems()}
							// uniqueIdExtractor={(item) => item.GetFullName()}
							children={(props) => (
								<DimensionBox
									Adornee={props}
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
