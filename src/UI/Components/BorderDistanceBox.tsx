/*
    Typed with ❤️ @mekstuff
    18/07/2025 17:47:27
*/

const GuiService = game.GetService("GuiService");

import Vivid, { Case, createCleanup, createEffect, createState, Switch, use, withProps } from "@mekstuff-rbxts/vivid";
import { Servant } from "@mekstuff-rbxts/core";
import { Tags } from "Core/Constants/Tags";
import { BorderDistanceLine, BorderDistanceLineProps } from "UI/Screens/BorderDistanceLine";
import { Theme } from "@mekstuff-rbxts/vivid-ui";
import { SettingsContext } from "Contexts/SettingsContexts";

type BorderDistanceBoxProps = {
	Adornee: GuiObject;
	TextColor3: Color3;
	BackgroundColor3: Color3;
};

function RenderBorderDistanceLine(props: BorderDistanceLineProps & { truthy: boolean }) {
	const Properties = withProps(props, true) as Partial<typeof props>;
	delete Properties.truthy;

	return (
		<Switch
			conditional={createEffect(() => {
				return props.truthy === true;
			})()}
		>
			<Case condition={true}>
				{() => <BorderDistanceLine {...(Properties as Required<typeof Properties>)} />}
			</Case>
			<Case condition={false}>{() => <></>}</Case>
		</Switch>
	);
}

export function BorderDistanceBox(props: BorderDistanceBoxProps) {
	const AdorneeStatic = use(() => props.Adornee);

	const [AdorneeAbsoluteSize, setAdorneeAbsoluteSize] = createState(use(() => AdorneeStatic.AbsoluteSize));
	const [AdorneeAbsolutePosition, setAdorneeAbsolutePosition] = createState(
		use(() => AdorneeStatic.AbsolutePosition),
	);

	const [Root, setRoot] = createState<GuiObject | Camera | undefined>(undefined);
	const [RootAbsoluteSize, setRootAbsoluteSize] = createState(Vector2.zero);
	const [RootAbsolutePosition, setRootAbsolutePosition] = createState(Vector2.zero);

	const [AncestorScreenGui, setAncestorScreenGui] = createState<ScreenGui | undefined>(undefined);

	const [LeftDistanceDiff, setLeftDistanceDiff] = createState(0);
	const [TopDistanceDiff, setTopDistanceDiff] = createState(0);
	const [RightDistanceDiff, setRightDistanceDiff] = createState(0);
	const [BottomDistanceDiff, setBottomDistanceDiff] = createState(0);

	createEffect(() => {
		const AncestryChangedListener = props.Adornee.AncestryChanged.Connect(() => {
			setAncestorScreenGui(props.Adornee.FindFirstAncestorWhichIsA("ScreenGui"));
		});
		setAncestorScreenGui(props.Adornee.FindFirstAncestorWhichIsA("ScreenGui"));
		createCleanup(() => {
			AncestryChangedListener.Disconnect();
		});
	});

	createEffect(() => {
		const CurrentRoot = Root();
		const CurrentAncestorScreenGui = AncestorScreenGui();
		setLeftDistanceDiff(AdorneeAbsolutePosition().X - RootAbsolutePosition().X);
		setTopDistanceDiff(
			AdorneeAbsolutePosition().Y -
				RootAbsolutePosition().Y +
				(CurrentRoot && CurrentAncestorScreenGui && CurrentRoot.IsA("Camera")
					? CurrentAncestorScreenGui.IgnoreGuiInset === true
						? GuiService.TopbarInset.Height
						: 0
					: 0),
		);
		setRightDistanceDiff(
			RootAbsolutePosition().X + RootAbsoluteSize().X - (AdorneeAbsolutePosition().X + AdorneeAbsoluteSize().X),
		);

		setBottomDistanceDiff(
			RootAbsolutePosition().Y +
				RootAbsoluteSize().Y -
				(AdorneeAbsolutePosition().Y + AdorneeAbsoluteSize().Y) -
				(CurrentRoot && CurrentAncestorScreenGui && CurrentRoot.IsA("Camera")
					? CurrentAncestorScreenGui.IgnoreGuiInset === true
						? GuiService.TopbarInset.Height
						: 0
					: 0),
		);
	});

	createEffect(() => {
		const TargetRoot = Root();
		if (TargetRoot === undefined) {
			setRootAbsoluteSize(Vector2.zero);
			setRootAbsolutePosition(Vector2.zero);
			return;
		}
		const RootServant = new Servant();

		if (TargetRoot.IsA("Camera")) {
			RootServant.Keep(
				TargetRoot.GetPropertyChangedSignal("ViewportSize").Connect(() => {
					setRootAbsoluteSize(TargetRoot.ViewportSize);
				}),
			);
			setRootAbsoluteSize(TargetRoot.ViewportSize);
			setRootAbsolutePosition(Vector2.zero);
		}
		if (TargetRoot.IsA("GuiObject")) {
			RootServant.Keep(
				TargetRoot.GetPropertyChangedSignal("AbsoluteSize").Connect(() => {
					setRootAbsoluteSize(TargetRoot.AbsoluteSize);
				}),
				TargetRoot.GetPropertyChangedSignal("AbsolutePosition").Connect(() => {
					setRootAbsolutePosition(TargetRoot.AbsolutePosition);
				}),
			);
			setRootAbsoluteSize(TargetRoot.AbsoluteSize);
			setRootAbsolutePosition(TargetRoot.AbsolutePosition);
		}

		createCleanup(() => {
			RootServant.Destroy();
		});
	});

	createEffect(() => {
		const UpdateRoot = () => {
			if (SettingsContext.CalculateBorderBoxRelativeToViewport.get() === true) {
				setRoot(game.Workspace.CurrentCamera);
				return;
			}
			const RootGuiObject = props.Adornee.FindFirstAncestorWhichIsA("GuiObject");
			if (RootGuiObject === undefined) {
				setRoot(game.Workspace.CurrentCamera);
				return;
			}
			setRoot(RootGuiObject);
		};
		const AdorneeParentListener = props.Adornee.GetPropertyChangedSignal("Parent").Connect(UpdateRoot);
		UpdateRoot();
		createCleanup(() => {
			AdorneeParentListener.Disconnect();
		});
	});

	createEffect(() => {
		const AbsolutePositionChangedListener = props.Adornee.GetPropertyChangedSignal("AbsolutePosition").Connect(
			() => {
				setAdorneeAbsolutePosition(props.Adornee.AbsolutePosition);
			},
		);
		createCleanup(() => {
			AbsolutePositionChangedListener.Disconnect();
		});
	});
	createEffect(() => {
		const AbsoluteSizeChangedListener = props.Adornee.GetPropertyChangedSignal("AbsoluteSize").Connect(() => {
			setAdorneeAbsoluteSize(props.Adornee.AbsoluteSize);
		});
		createCleanup(() => {
			AbsoluteSizeChangedListener.Disconnect();
		});
	});

	return (
		<frame
			tags={[Tags.IgnoreHoverDetection]}
			BackgroundTransparency={0.8}
			BackgroundColor3={props.BackgroundColor3}
			Size={createEffect(() => {
				return UDim2.fromOffset(AdorneeAbsoluteSize().X, AdorneeAbsoluteSize().Y);
			})}
			Position={createEffect(() => {
				return UDim2.fromOffset(AdorneeAbsolutePosition().X, AdorneeAbsolutePosition().Y);
			})}
		>
			<RenderBorderDistanceLine
				truthy={SettingsContext.ShowLeftBorderBox.get()}
				Thickness={2}
				BorderColor={Theme().ButtonBorder}
				PrimaryColor={props.BackgroundColor3}
				TextColor={props.TextColor3}
				Length={LeftDistanceDiff()}
				Position="Left"
			/>
			<RenderBorderDistanceLine
				truthy={SettingsContext.ShowTopBorderBox.get()}
				Thickness={2}
				BorderColor={Theme().ButtonBorder}
				PrimaryColor={props.BackgroundColor3}
				TextColor={props.TextColor3}
				Length={TopDistanceDiff()}
				Position="Top"
			/>
			<RenderBorderDistanceLine
				truthy={SettingsContext.ShowRightBorderBox.get()}
				Thickness={2}
				BorderColor={Theme().ButtonBorder}
				PrimaryColor={props.BackgroundColor3}
				TextColor={props.TextColor3}
				Length={RightDistanceDiff()}
				Position="Right"
			/>
			<RenderBorderDistanceLine
				truthy={SettingsContext.ShowBottomBorderBox.get()}
				Thickness={2}
				BorderColor={Theme().ButtonBorder}
				PrimaryColor={props.BackgroundColor3}
				TextColor={props.TextColor3}
				Length={BottomDistanceDiff()}
				Position="Bottom"
			/>
		</frame>
	);
}
