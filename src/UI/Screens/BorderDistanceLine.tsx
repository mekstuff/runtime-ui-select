/*
    Typed with ❤️ @mekstuff
    18/07/2025 18:15:08
*/

import Vivid, { createEffect, createState } from "@mekstuff-rbxts/vivid";
import { Tags } from "Core/Constants/Tags";
import { RoundTo2DecimalPlaces } from "Core/Functions/Format";

export type BorderDistanceLineProps = {
	PrimaryColor: Color3;
	TextColor: Color3;
	BorderColor: Color3;
	Position: "Left" | "Top" | "Right" | "Bottom";
	Length: number;
	Thickness: number;
};

export function BorderDistanceLine(props: BorderDistanceLineProps) {
	const LineBorderThickness = 0.45;
	const [Size, setSize] = createState(new UDim2());
	const [Position, setPosition] = createState(new UDim2());
	const [AnchorPoint, setAnchorPoint] = createState(Vector2.zero);

	const UpdatePositioning = () => {
		if (props.Position === "Left") {
			setAnchorPoint(new Vector2(1, 0.5));
			setPosition(UDim2.fromScale(0, 0.5));
			return;
		}
		if (props.Position === "Top") {
			setAnchorPoint(new Vector2(0.5, 1));
			setPosition(UDim2.fromScale(0.5, 0));
			return;
		}
		if (props.Position === "Right") {
			setAnchorPoint(new Vector2(0, 0.5));
			setPosition(UDim2.fromScale(1, 0.5));
			return;
		}
		if (props.Position === "Bottom") {
			setAnchorPoint(new Vector2(0.5, 0));
			setPosition(UDim2.fromScale(0.5, 1));
			return;
		}
	};

	const UpdateSizing = () => {
		if (props.Position === "Left" || props.Position === "Right") {
			setSize(UDim2.fromOffset(props.Length, props.Thickness));
			return;
		}
		if (props.Position === "Top" || props.Position === "Bottom") {
			setSize(UDim2.fromOffset(props.Thickness, props.Length));
			return;
		}
	};

	createEffect(() => {
		props.Position; // dependency
		UpdatePositioning();
	});

	createEffect(() => {
		props.Position; // dependency
		props.Length; // dependency
		UpdateSizing();
	});

	return (
		<frame
			tags={[Tags.IgnoreHoverDetection]}
			Size={Size()}
			Position={Position()}
			AnchorPoint={AnchorPoint()}
			BackgroundTransparency={0}
			BackgroundColor3={props.PrimaryColor}
			BorderSizePixel={0}
		>
			<uistroke Color={props.BorderColor} Thickness={LineBorderThickness} />

			<textlabel
				tags={[Tags.IgnoreHoverDetection]}
				AutomaticSize={Enum.AutomaticSize.XY}
				Text={createEffect(() => `${RoundTo2DecimalPlaces(props.Length)}`)()}
				AnchorPoint={new Vector2(0.5, 0.5)}
				Position={UDim2.fromScale(0.5, 0.5)}
				TextColor3={props.TextColor}
				BackgroundColor3={props.PrimaryColor}
				BorderSizePixel={0}
			>
				<uipadding
					PaddingLeft={new UDim(0, 2)}
					PaddingTop={new UDim(0, 2)}
					PaddingRight={new UDim(0, 2)}
					PaddingBottom={new UDim(0, 2)}
				/>
				<uicorner CornerRadius={new UDim(0.3, 0)} />
				<uistroke
					ApplyStrokeMode={Enum.ApplyStrokeMode.Border}
					Color={props.BorderColor}
					Thickness={LineBorderThickness}
				/>
			</textlabel>
		</frame>
	);
}
