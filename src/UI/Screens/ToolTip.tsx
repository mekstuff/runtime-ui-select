import Vivid, { createCleanup, createEffect, createSpring, createState, onMount } from "@mekstuff-rbxts/vivid";
import { Collector } from "@mekstuff-rbxts/collector";

const RunService = game.GetService("RunService");

import { createRef } from "@mekstuff-rbxts/vivid/out/create/createRef";
import { Theme, Units } from "@mekstuff-rbxts/vivid-ui";
import { Constants } from "Core/Constants/Constants";
import { SettingsContext } from "Contexts/SettingsContexts";

export function ToolTip(props: { MainWidget: DockWidgetPluginGui }) {
	const [CurrentTip, setCurrentTip, CurrentTipState] = createState<string | undefined>(undefined);
	const [CurrentPosition, setCurrentPosition] = createState<UDim2 | undefined>(new UDim2());
	const [ToolTipDelayValue, setToolTipDelayValue, ToolTipDelayValueState] = createSpring(0); // 0=off | 1=on (delay on hovering)
	const LabelReference = createRef<TextLabel>();

	onMount(() => {
		const Binder = Collector.Bind<GuiObject>(Constants.MainWidgetToolTipCollectionId, (Object) => {
			const MouseEnterConnection = Object.MouseEnter.Connect(() => {
				setCurrentTip(Object.GetAttribute(Constants.MainWidgetToolTipCollectionId) as string | undefined);
			});
			const MouseLeaveConnection = Object.MouseLeave.Connect(() => {
				if (CurrentTipState.State !== Object.GetAttribute(Constants.MainWidgetToolTipCollectionId)) {
					return;
				}
				setCurrentTip(undefined);
			});
			return () => {
				MouseEnterConnection.Disconnect();
				MouseLeaveConnection.Disconnect();
			};
		});
		createCleanup(() => {
			Binder.Destroy();
		});
	});

	onMount(() => {
		createEffect(() => {
			if (
				CurrentTip() === undefined ||
				LabelReference() === undefined ||
				SettingsContext.DisableToolTips.get() === true
			) {
				setCurrentPosition(undefined);
				return;
			}
			const Ref = LabelReference();
			const PluginMouseMoveListener = RunService.Heartbeat.Connect(() => {
				const MouseRelativePosition = props.MainWidget.GetRelativeMousePosition();
				const Offset = new Vector2(5, 10);
				const ComponentXPosition = MouseRelativePosition.X + Ref!.AbsoluteSize.X + Offset.X;
				const ComponentYPosition = MouseRelativePosition.Y + Ref!.AbsoluteSize.Y + Offset.Y;
				setCurrentPosition(
					UDim2.fromOffset(
						ComponentXPosition > props.MainWidget.AbsoluteSize.X
							? props.MainWidget.AbsoluteSize.X - Ref!.AbsoluteSize.X
							: MouseRelativePosition.X + Offset.X,
						ComponentYPosition > props.MainWidget.AbsoluteSize.Y
							? props.MainWidget.AbsoluteSize.Y - Ref!.AbsoluteSize.Y
							: MouseRelativePosition.Y + Offset.Y,
					),
				);
			});
			createCleanup(() => {
				PluginMouseMoveListener.Disconnect();
			});
		});
	});

	createEffect(() => {
		if (CurrentTip() !== undefined) {
			setToolTipDelayValue(1);
		} else {
			ToolTipDelayValueState.State = 0;
		}
	});

	return (
		<textlabel
			ref={LabelReference}
			Name={"WidgetToolTips"}
			TextWrapped={true}
			ZIndex={99}
			BackgroundColor3={Theme().Tooltip}
			TextColor3={Theme().SubText}
			TextSize={() => Units().BaseTextSize}
			AutomaticSize={Enum.AutomaticSize.XY}
			Size={new UDim2()}
			BackgroundTransparency={0.1}
			Text={() => CurrentTip() ?? ""}
			Position={() => {
				return CurrentPosition() ?? new UDim2();
			}}
			Visible={() => {
				return (
					ToolTipDelayValue() >= 1 &&
					CurrentPosition() !== undefined &&
					SettingsContext.DisableToolTips.get() === false
				);
			}}
			Parent={props.MainWidget}
		>
			<uistroke ApplyStrokeMode={Enum.ApplyStrokeMode.Border} Color={Theme().Border} />
			<uipadding
				PaddingLeft={new UDim(0, 6)}
				PaddingTop={new UDim(0, 4)}
				PaddingRight={new UDim(0, 6)}
				PaddingBottom={new UDim(0, 4)}
			/>
			<uicorner CornerRadius={new UDim(0, 4)} />
		</textlabel>
	);
}
