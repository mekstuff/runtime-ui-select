/*
    Typed with ❤️ @mekstuff
    16/07/2025 00:21:17
*/

import Vivid, { createCleanup, createEffect, createState, use } from "@mekstuff-rbxts/vivid";
import { Button } from "@mekstuff-rbxts/vivid-ui";
import { GetIsNonPluginEnv } from "Core/Functions/GetUsageContext";
import { UnavailableFeature } from "./UnavailableFeature";
import { Constants } from "Core/Constants/Constants";

export function ThemeToggleButton() {
	if (GetIsNonPluginEnv() === true) {
		return <UnavailableFeature />;
	}
	const SettingsStudio = settings().Studio as Studio & { Theme: Instance };
	const [CurrentTheme, setCurrentTheme] = createState(SettingsStudio.Theme);
	const [AvailableThemes, setAvailableThemes] = createState(SettingsStudio.GetAvailableThemes() as Instance[]);

	const ThemeChangedListener = SettingsStudio.ThemeChanged.Connect(() => {
		setCurrentTheme(SettingsStudio.Theme);
		setAvailableThemes(SettingsStudio.GetAvailableThemes() as Instance[]);
	});

	createCleanup(() => {
		ThemeChangedListener.Disconnect();
	});

	return (
		<Button
			Size={UDim2.fromScale(1)}
			Text={createEffect(() => {
				return CurrentTheme().Name;
			})}
			Activated={() => {
				const CurrentAvailableThemes = use(() => AvailableThemes());
				const CurrentThemeInstance = use(() => CurrentTheme());
				const CurrentIndex = CurrentAvailableThemes.indexOf(CurrentThemeInstance);
				const TargetIndex = CurrentAvailableThemes[CurrentIndex + 1] === undefined ? 0 : CurrentIndex + 1;

				SettingsStudio.Theme = CurrentAvailableThemes[TargetIndex];
			}}
		/>
	);
}
