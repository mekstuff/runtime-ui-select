import { createElement, StoryAdapters } from "@mekstuff-rbxts/vivid";
import { SettingsScreen } from "UI/Screens/SettingsScreen";

export = StoryAdapters.UILabs({}, () => {
	return createElement(SettingsScreen);
});
