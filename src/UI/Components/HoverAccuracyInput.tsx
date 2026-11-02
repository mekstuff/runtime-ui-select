/*
    Typed with ❤️ @mekstuff
    22/07/2025 12:48:39
*/

import Vivid, { createCleanup, createEffect, createRef } from "@mekstuff-rbxts/vivid";
import { Input } from "@mekstuff-rbxts/vivid-ui";
import { HoverDetectionAccuracyNumberRange, SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { RoundTo2DecimalPlaces } from "Core/Functions/Format";

export function HoverAccuracyInput() {
	const InputRef = createRef<TextBox>();

	createEffect(() => {
		const TextBox = InputRef();
		if (TextBox === undefined) {
			return;
		}
		const FocusLostListener = TextBox.FocusLost.Connect(() => {
			const TargetValue = tonumber(TextBox.Text);
			TextBox.Text = "";
			if (TargetValue === undefined) {
				return;
			}
			SettingsContext.HoverDetectionAccuracy.set(
				math.clamp(
					RoundTo2DecimalPlaces(TargetValue),
					HoverDetectionAccuracyNumberRange.Min,
					HoverDetectionAccuracyNumberRange.Max,
				),
			);
		});
		createCleanup(() => {
			FocusLostListener.Disconnect();
		});
	});

	return (
		<Input
			ref={InputRef}
			Size={UDim2.fromScale(1)}
			AutomaticSize={Enum.AutomaticSize.Y}
			TextXAlignment={Enum.TextXAlignment.Center}
			Text={""}
			// Text={createEffect(() => tostring(SettingsContext.HoverDetectionAccuracy.get()))}
			PlaceholderText={createEffect(() => tostring(SettingsContext.HoverDetectionAccuracy.get()))}
		/>
	);
}
