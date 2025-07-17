/*
    Typed with ❤️ @mekstuff
    13/07/2025 20:20:58
*/

const GuiService = game.GetService("GuiService");

import Vivid, { Box, createCleanup, createEffect, createRef, createState, WithTransition } from "@mekstuff-rbxts/vivid";
import { Tags } from "Core/Constants/Tags";

export function DimensionBoxTextInfoList(props: {
	AnchorPoint: Vector2;
	Position: UDim2;
	BackgroundColor: Color3;
	PrimaryColor: Color3;
	ViewportSize: Vector2;

	children?: Instance[];
}) {
	const [PositionXOffset, setPositionXOffset] = createState(0);
	const [PositionYOffset, setPositionYOffset] = createState(0);
	const BoxRef = createRef<Frame>();

	createEffect(() => {
		const Ref = BoxRef();
		if (Ref === undefined) {
			return;
		}

		const UpdateBoundings = () => {
			const GuiInset = GuiService.TopbarInset;
			// X Axis
			if (Ref.AbsolutePosition.X < 0) {
				setPositionXOffset(math.abs(Ref.AbsolutePosition.X));
			} else if (Ref.AbsolutePosition.X + Ref.AbsoluteSize.X > props.ViewportSize.X) {
				setPositionXOffset(-math.abs(Ref.AbsolutePosition.X + Ref.AbsoluteSize.X - props.ViewportSize.X));
			} else {
				setPositionXOffset(0);
			}

			// Y Axis
			const AbsolutePositionY = Ref.AbsolutePosition.Y + GuiInset.Height;
			if (AbsolutePositionY < 0) {
				setPositionYOffset(math.abs(AbsolutePositionY));
			} else if (AbsolutePositionY + Ref.AbsoluteSize.Y > props.ViewportSize.Y) {
				setPositionYOffset(-math.abs(AbsolutePositionY + Ref.AbsoluteSize.Y - props.ViewportSize.Y));
			} else {
				setPositionYOffset(0);
			}
		};

		const AbsoluteSizeListener = Ref.GetPropertyChangedSignal("AbsoluteSize").Connect(UpdateBoundings);
		UpdateBoundings();
		createCleanup(() => {
			AbsoluteSizeListener.Disconnect();
		});
	});

	return (
		<frame
			ref={BoxRef}
			tags={[Tags.IgnoreHoverDetection]}
			AnchorPoint={props.AnchorPoint}
			Position={createEffect(() => {
				return props.Position.add(UDim2.fromOffset(PositionXOffset(), PositionYOffset()));
			})}
			AutomaticSize={Enum.AutomaticSize.XY}
			BackgroundTransparency={1}
		>
			<Box
				tags={[Tags.IgnoreHoverDetection]}
				FillDirection={Enum.FillDirection.Horizontal}
				VerticalAlignment={Enum.VerticalAlignment.Center}
				HorizontalAlignment={Enum.HorizontalAlignment.Right}
				UIPadding={2}
				Padding={new UDim(0, 4)}
				AutomaticSize={Enum.AutomaticSize.XY}
				BackgroundColor3={props.BackgroundColor}
				BackgroundTransparency={createEffect(() => {
					return WithTransition(0.05, {
						DefaultValue: 1,
					});
				})}
				BorderSizePixel={0}
			>
				<uicorner CornerRadius={new UDim(0, 1)} />
				<uistroke
					Transparency={0.05}
					Color={props.PrimaryColor}
					ApplyStrokeMode={Enum.ApplyStrokeMode.Border}
				/>
				{props.children?.map((child) => {
					return child;
				})}
			</Box>
		</frame>
	);
}
