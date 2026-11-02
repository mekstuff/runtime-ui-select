/*
    Typed with ❤️ @mekstuff
    19/07/2025 15:10:44
*/

import Vivid from "@mekstuff-rbxts/vivid";
import { Button, Icons, Theme } from "@mekstuff-rbxts/vivid-ui";
import { Constants } from "Core/Constants/Constants";

export function UnavailableFeature() {
	return (
		<Button
			props={{
				IconImage: {
					ImageColor3: Theme().ErrorText,
				},
			}}
			icon={Icons.fromName("fluency", "outline", "warning-error")}
			variant="ghost"
			Interactable={false}
			Text={""}
			BackgroundTransparency={1}
		/>
	);
}
