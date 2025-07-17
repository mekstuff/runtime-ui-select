import Vivid, { createCleanup, createEffect, use } from "@mekstuff-rbxts/vivid";
import { SettingContent, ToggleSwitch } from "@mekstuff-rbxts/vivid-ui";
import { SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";

export function BindedSettingContextToggleSwitch(props: {
	Text: string;
	TargetSettingContext: keyof typeof SettingsContext;
	Dependencies?: (keyof typeof SettingsContext)[];
	ToolTip?: string;
}) {
	return (
		<frame
			tags={[Constants.MainWidgetToolTipCollectionId]}
			attributes={{
				[Constants.MainWidgetToolTipCollectionId]: createEffect(() => {
					const DependenciesString =
						props.Dependencies !== undefined ? `Requires: ${props.Dependencies.join(", ")}` : undefined;
					// return (
					if (props.ToolTip === undefined) {
						return DependenciesString ?? "";
					}
					if (DependenciesString === undefined) {
						return props.ToolTip;
					}

					return props.ToolTip + `\n\n${DependenciesString}`;
				})(),
			}}
			AutomaticSize={Enum.AutomaticSize.XY}
			BackgroundTransparency={1}
		>
			<SettingContent titleText={props.Text} scaleDistribution={0.8}>
				<ToggleSwitch
					toggled={SettingsContext[use(() => props.TargetSettingContext)].get()}
					disabled={createEffect(() => {
						if (props.Dependencies === undefined) {
							return false;
						}
						for (const [_, Dependency] of pairs(props.Dependencies)) {
							if (SettingsContext[Dependency].get() === false) {
								let oldState = false;
								SettingsContext[use(() => props.TargetSettingContext)].set((old) => {
									oldState = old;
									return false;
								});
								createCleanup((isDestroying) => {
									if (isDestroying) {
										return;
									}
									SettingsContext[use(() => props.TargetSettingContext)].set(oldState);
								});
								return true;
							}
						}
						return false;
					})()}
					Activated={() => {
						SettingsContext[use(() => props.TargetSettingContext)].set((old) => !old);
					}}
				/>
			</SettingContent>
		</frame>
	);
}
