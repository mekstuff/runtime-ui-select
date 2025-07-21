/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:21:35
*/

import { createScope, createState } from "@mekstuff-rbxts/vivid";
import { Icons } from "@mekstuff-rbxts/vivid-ui";

const ConstantsScope = createScope();

const PluginDisplayIcon = "rbxassetid://134897990664604"; // Icons.fromName("fluency", "outline", "mouse-cursor-click"); // "rbxassetid://139503145506932" as const;
const PluginDisplayIconDark = "rbxassetid://106856596627232"; // Icons.fromName("fluency", "outline", "mouse-cursor-click"); // "rbxassetid://139297535327952" as const;

function GetDynamicPluginDisplayIcon(): string {
	return (settings().Studio as unknown as { Theme: Instance }).Theme.Name === "Dark"
		? PluginDisplayIcon
		: PluginDisplayIconDark;
}

const [Dynamic_PluginDisplayIcon, setDynamic_PluginDisplayIcon] = createState(GetDynamicPluginDisplayIcon());

const ThemeChangedListener = settings().Studio.ThemeChanged.Connect(() => {
	setDynamic_PluginDisplayIcon(GetDynamicPluginDisplayIcon());
});
ConstantsScope.Servant.Keep(ThemeChangedListener);

const PluginDisplayName = "Runtime UI Select";

export const Constants = {
	PluginDisplayName,
	PluginDisplayIcon,
	PluginDisplayIconDark,
	Dynamic_PluginDisplayIcon,

	PluginWidgetIdentifierPrefix: "runtime-ui-select",
	PluginSharedSettingsKey: "PluginSharedSettings",
	PluginSharedSettingTokenListener: `${PluginDisplayName}-PluginSharedSettingTokenListener`,
	MainWidgetToolTipCollectionId: "MainWidgetToolTipCollectionId",
	ScreenGuiDisplayOrderLimit: 2147483647,
};

ConstantsScope.Close();
