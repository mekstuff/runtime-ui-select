/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:18:19
*/

import Vivid, { createEffect, createScope, Suspense, use } from "@mekstuff-rbxts/vivid";
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
					new DockWidgetPluginGuiInfo(Enum.InitialDockState.Float, false, false, 300, 450, 300, 450),
				) as DockWidgetPluginGui & { Title: string };
				Widget.Title = `${Constants.PluginAcroName}${GetIsRunningSession() ? " - Client" : ""}`;

				if (GetPlugin().GetSetting(Constants.PluginSharedSettingsKey) === undefined) {
					// FTUE
					Widget.Enabled = true;
				}

				const SettingsWidgetButton = use(() => props.Toolbar).CreateButton(
					Constants.PluginDisplayName,
					"Select GUI During Runtime.",
					use(() => Constants.Dynamic_PluginDisplayIcon()),
				);

				const DynamicIconScope = createScope();
				createEffect(() => {
					(SettingsWidgetButton as unknown as { Icon: string }).Icon = Constants.Dynamic_PluginDisplayIcon();
				});

				DynamicIconScope.Close();

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
