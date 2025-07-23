/*
	Typed with ❤️ @mekstuff
	02/07/2025 22:12:38
*/

import Vivid, { Case, createCleanup, createEffect, Switch, use } from "@mekstuff-rbxts/vivid";
import { SettingContent, ToggleSwitch } from "@mekstuff-rbxts/vivid-ui";
import { SettingsContext, SettingState } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { UnavailableFeature } from "./UnavailableFeature";

export function BindedSettingContextToggleSwitch(props: {
	Text: string;
	TargetSettingContext: keyof typeof SettingsContext;
	Dependencies?: (keyof typeof SettingsContext)[];
	InverseDependencies?: (keyof typeof SettingsContext)[];
	UnavailableFeature?: boolean;
	ToolTip?: string;
	hideSplitter?: boolean;
}) {
	const SettingContextObject = SettingsContext[use(() => props.TargetSettingContext)] as SettingState<boolean>;

	assert(
		typeIs(
			use(() => SettingContextObject.get()),
			"boolean",
		),
		"SettingContextObject not a boolean.",
	);

	return (
		<frame
			tags={[Constants.MainWidgetToolTipCollectionId]}
			attributes={{
				[Constants.MainWidgetToolTipCollectionId]: createEffect(() => {
					const DependenciesString =
						props.Dependencies || props.InverseDependencies !== undefined
							? `Requires: ${[...(props.Dependencies ?? []), ...(props.InverseDependencies?.map((InverseDep) => `Not ${InverseDep}`) ?? [])].join(", ")}`
							: undefined;
					// return (
					if (props.ToolTip === undefined) {
						return DependenciesString ?? "";
					}
					if (DependenciesString === undefined) {
						return props.ToolTip;
					}

					return props.ToolTip + `\n\n${DependenciesString}`;
				})(),
				[Constants.SearchFilterMatchAttribute]: props.Text,
			}}
			AutomaticSize={Enum.AutomaticSize.XY}
			BackgroundTransparency={1}
		>
			<SettingContent titleText={props.Text} scaleDistribution={0.8} hideSplitter={props.hideSplitter}>
				<Switch conditional={createEffect(() => props.UnavailableFeature === true)()}>
					<Case condition={true}>{() => <UnavailableFeature />}</Case>
					<Case condition={false}>
						{() => (
							<ToggleSwitch
								toggled={SettingContextObject.get()}
								disabled={createEffect(() => {
									if (props.Dependencies !== undefined) {
										for (const [_, Dependency] of pairs(props.Dependencies)) {
											if (SettingsContext[Dependency].get() === false) {
												let oldState = false;
												SettingContextObject.set((old) => {
													oldState = old;
													return false;
												});
												createCleanup((isDestroying) => {
													if (isDestroying) {
														return;
													}
													SettingContextObject.set(oldState);
												});
												return true;
											}
										}
									}
									if (props.InverseDependencies !== undefined) {
										for (const [_, InverseDependency] of pairs(props.InverseDependencies)) {
											if (SettingsContext[InverseDependency].get() === true) {
												let oldState = false;
												SettingContextObject.set((old) => {
													oldState = old;
													return false;
												});
												createCleanup((isDestroying) => {
													if (isDestroying) {
														return;
													}
													SettingContextObject.set(oldState);
												});
												return true;
											}
										}
									}
									return false;
								})()}
								Activated={() => {
									SettingContextObject.set((old) => !old);
								}}
							/>
						)}
					</Case>
				</Switch>
			</SettingContent>
		</frame>
	);
}
