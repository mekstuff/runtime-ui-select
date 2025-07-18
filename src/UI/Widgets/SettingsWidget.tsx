/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:18:19
*/

import Vivid, { Suspense, use } from "@mekstuff-rbxts/vivid";
import { Constants } from "Core/Constants/Constants";
import { GetPlugin } from "Core/Functions/GetPlugin";
import { GetIsRunningSession } from "Core/Functions/GetUsageContext";
import { SettingsScreen } from "UI/Screens/SettingsScreen";
import { ToolTip } from "UI/Screens/ToolTip";

export function SettingsWidget(props: { Toolbar: PluginToolbar }) {
	return (
		<Suspense>
			{() => {
				const Widget = GetPlugin().CreateDockWidgetPluginGui(
					`${Constants.PluginWidgetIdentifierPrefix}_${math.random()}`,
					new DockWidgetPluginGuiInfo(Enum.InitialDockState.Float),
				) as DockWidgetPluginGui & { Title: string };
				Widget.Title = `${Constants.PluginDisplayName}${GetIsRunningSession() ? " - Client" : ""}`;
				Widget.Enabled = true;

				const SettingsWidgetButton = use(() => props.Toolbar).CreateButton(
					Constants.PluginDisplayName,
					"Select GUI During Runtime.",
					Constants.PluginDisplayIcon,
				);

				SettingsWidgetButton.Click.Connect(() => {
					Widget.Enabled = !Widget.Enabled;
				});

				<frame Parent={Widget} Size={UDim2.fromScale(1, 1)} BackgroundTransparency={1}>
					<SettingsScreen />
					<ToolTip MainWidget={Widget} />
				</frame>;

				return Widget;
			}}
		</Suspense>
	);
}
