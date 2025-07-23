/*
    Typed with ❤️ @mekstuff
    02/07/2025 23:47:47
*/

import Vivid, { createCleanup, createEffect, createState, use, WithTransition } from "@mekstuff-rbxts/vivid";
import { Tags } from "Core/Constants/Tags";
import { RoundTo2DecimalPlaces } from "Core/Functions/Format";
import { DimensionBoxTextInfo } from "./DimensionBoxTextInfo";
import { DimensionBoxTextInfoList } from "./DimensionBoxTextInfoList";
import { Theme } from "@mekstuff-rbxts/vivid-ui";
import { SettingsContext } from "Contexts/SettingsContexts";

type DimensionBoxProps = {
	Adornee: GuiObject;
	PrimaryColor: Color3;
	BackgroundColor: Color3;
	ShowAbsoluteSize: boolean;
	ShowAbsolutePosition: boolean;
	ShowInstanceName: boolean;

	ViewportSize: Vector2;
};

export function DimensionBox(props: DimensionBoxProps) {
	const AdorneeStatic = use(() => props.Adornee);

	const [AdorneeAbsoluteSize, setAdorneeAbsoluteSize] = createState(use(() => AdorneeStatic.AbsoluteSize));
	const [AdorneeAbsolutePosition, setAdorneeAbsolutePosition] = createState(
		use(() => AdorneeStatic.AbsolutePosition),
	);

	createEffect(() => {
		const AbsolutePositionChangedListener = props.Adornee.GetPropertyChangedSignal("AbsolutePosition").Connect(
			() => {
				if (props.Adornee === undefined) {
					return;
				}
				setAdorneeAbsolutePosition(props.Adornee.AbsolutePosition);
			},
		);
		createCleanup(() => {
			AbsolutePositionChangedListener.Disconnect();
		});
	});
	createEffect(() => {
		const AbsoluteSizeChangedListener = props.Adornee.GetPropertyChangedSignal("AbsoluteSize").Connect(() => {
			if (props.Adornee === undefined) {
				return;
			}
			setAdorneeAbsoluteSize(props.Adornee.AbsoluteSize);
		});
		createCleanup(() => {
			AbsoluteSizeChangedListener.Disconnect();
		});
	});

	return (
		<frame
			tags={[Tags.IgnoreHoverDetection]}
			BackgroundTransparency={1}
			Size={createEffect(() => {
				return UDim2.fromOffset(AdorneeAbsoluteSize().X, AdorneeAbsoluteSize().Y);
			})}
			Position={createEffect(() => {
				return UDim2.fromOffset(AdorneeAbsolutePosition().X, AdorneeAbsolutePosition().Y);
			})}
		>
			<uistroke
				Thickness={2}
				Transparency={createEffect(() => {
					return WithTransition(0, {
						DefaultValue: 1,
					});
				})}
				Color={props.PrimaryColor}
			/>

			{/* Top List */}
			<DimensionBoxTextInfoList
				ViewportSize={props.ViewportSize}
				AnchorPoint={new Vector2(1, 1)}
				Position={new UDim2(1, 0, 0, -6)}
				PrimaryColor={props.PrimaryColor}
				BackgroundColor={props.BackgroundColor}
				children={[
					<DimensionBoxTextInfo
						truthy={createEffect(() => props.ShowAbsoluteSize)()}
						Text={createEffect(() => {
							return `${RoundTo2DecimalPlaces(AdorneeAbsoluteSize().X)}w X ${RoundTo2DecimalPlaces(AdorneeAbsoluteSize().Y)}h`;
						})}
					/>,
				]}
			/>

			{/* Click Blocker Button */}
			<textbutton
				tags={[Tags.IgnoreHoverDetection]}
				Active={true}
				Interactable={true}
				Text={""}
				Visible={SettingsContext.BlockButtonActivations.get()}
				BackgroundTransparency={1}
				Size={UDim2.fromScale(1, 1)}
			/>

			{/* Bottom List */}
			<DimensionBoxTextInfoList
				ViewportSize={props.ViewportSize}
				AnchorPoint={new Vector2(1, 0)}
				Position={new UDim2(1, 0, 1, 6)}
				PrimaryColor={props.PrimaryColor}
				BackgroundColor={props.BackgroundColor}
				children={[
					<DimensionBoxTextInfo
						truthy={createEffect(() => props.ShowAbsolutePosition)()}
						Text={createEffect(() => {
							return `${RoundTo2DecimalPlaces(AdorneeAbsolutePosition().X)} x ${RoundTo2DecimalPlaces(AdorneeAbsolutePosition().Y)}`;
						})}
					/>,
					<DimensionBoxTextInfo
						truthy={createEffect(() => props.ShowInstanceName)()}
						Text={createEffect(() => {
							if (props.Adornee === undefined) {
								return "";
							}
							return `${props.Adornee.Name}`;
						})()}
						TextColor3={Theme().MainButton}
					/>,
				]}
			/>
		</frame>
	);
}
