/*
	Typed with ❤️ @mekstuff
	19/07/2025 20:23:50
*/

const RunService = game.GetService("RunService");
const ContextActionService = game.GetService("ContextActionService");

import Vivid, {
	Box,
	createCleanup,
	createEffect,
	createState,
	useResponsive,
	WithTransition,
} from "@mekstuff-rbxts/vivid";
import { Icons, Input, Label, Theme } from "@mekstuff-rbxts/vivid-ui";
import { HoverDimensionBoxes } from "@mekstuff-rbxts/runtime-ui-select/out/UI/Screens/HoverDimensionBoxes";
import { BorderDistanceBoxes } from "@mekstuff-rbxts/runtime-ui-select/out/UI/Screens/BorderDistanceBoxes";
import { ToolTip } from "@mekstuff-rbxts/runtime-ui-select/out/UI/Screens/ToolTip";
import { UnavailableFeature } from "@mekstuff-rbxts/runtime-ui-select/out/UI/Components/UnavailableFeature";
import { SettingsScreen } from "@mekstuff-rbxts/runtime-ui-select/out/UI/Screens/SettingsScreen";
import { SettingsContext } from "@mekstuff-rbxts/runtime-ui-select/out/Contexts/SettingsContexts";
import { Tags } from "@mekstuff-rbxts/runtime-ui-select/out/Core/Constants/Tags";

const IsStudio = RunService.IsStudio();

ContextActionService.BindAction(
	tostring(math.random()),
	() => Enum.ContextActionResult.Sink,
	false,
	...Enum.PlayerActions.GetEnumItems(),
);

if (IsStudio === false) {
	SettingsContext.UseHoverDetectionActivationKeybind.set(false);
}

const Players = game.GetService("Players");
const GuiService = game.GetService("GuiService");
const UserInputService = game.GetService("UserInputService");
const PlayerGui = Players.LocalPlayer.WaitForChild("PlayerGui") as PlayerGui;

const DemoUIs = PlayerGui.WaitForChild("DemoUIs") as ScreenGui;
DemoUIs.ResetOnSpawn = false;

function RuntimeUISelectClientDemo() {
	return (
		<>
			<HoverDimensionBoxes />
			<BorderDistanceBoxes />
		</>
	);
}

function DisplayScreen(props: { children?: unknown }) {
	const [TopBarInsetHeight, setTopBarInsetHeight] = createState(GuiService.TopbarInset.Height + 10);
	const TopbarInsetChangedListener = GuiService.GetPropertyChangedSignal("TopbarInset").Connect(() => {
		setTopBarInsetHeight(GuiService.TopbarInset.Height + 10);
	});
	createCleanup(() => {
		TopbarInsetChangedListener.Disconnect();
	});

	const [SideDistribution, setSideDistribution] = createState(0.25);

	const [Responsive] = useResponsive();

	createEffect(() => {
		setSideDistribution(Responsive() === "sm" || Responsive() === "md" ? 0.4 : 0.25);
	});

	return (
		<screengui IgnoreGuiInset Parent={PlayerGui}>
			<frame Size={UDim2.fromScale(1, 1)} BackgroundColor3={Theme().ButtonBorder}>
				<Label
					BackgroundTransparency={1}
					Size={createEffect(() => new UDim2(1, 0, 0, TopBarInsetHeight()))()}
					Text={
						"Rutus Plugin Demo\nMade with ❤️ @Mekstuff\n\nYou will be able to select the GUI items within the studio*"
					}
					TextColor3={Theme().DimmedText}
					TextXAlignment={Enum.TextXAlignment.Center}
				/>
				<frame
					Position={createEffect(() => new UDim2(0, 0, 0, TopBarInsetHeight()))}
					Size={createEffect(() => new UDim2(1, 0, 1, -TopBarInsetHeight()))}
					BackgroundTransparency={1}
				>
					<Box
						Size={UDim2.fromScale(1, 1)}
						FillDirection={Enum.FillDirection.Horizontal}
						BackgroundTransparency={1}
						Padding={new UDim(0, 4)}
					>
						{/* Left Side */}
						<frame
							Size={createEffect(() => new UDim2(SideDistribution(), 0, 1, 0))()}
							BackgroundTransparency={1}
						>
							<uistroke Thickness={3} />
							<Box BackgroundTransparency={1} Size={UDim2.fromScale(1, 1)} Padding={new UDim(0, 6)}>
								{/* Info */}
								<Box
									BackgroundTransparency={1}
									Size={new UDim2(1, 0, 0, 0)}
									AutomaticSize={Enum.AutomaticSize.Y}
									FillDirection={Enum.FillDirection.Vertical}
									Padding={new UDim(0, 4)}
									UIPadding={12}
								>
									<Box
										FillDirection={Enum.FillDirection.Vertical}
										BackgroundTransparency={1}
										AutomaticSize={Enum.AutomaticSize.XY}
									>
										<Label
											BackgroundTransparency={1}
											Size={new UDim2(1, 0, 0, 0)}
											AutomaticSize={Enum.AutomaticSize.Y}
											Text={"Settings that are only available within the plugin will display:"}
											TextColor3={Theme().DimmedText}
											TextXAlignment={Enum.TextXAlignment.Left}
											TextWrapped={true}
										/>
										<UnavailableFeature />
									</Box>
								</Box>
								{/* Settings */}
								<frame BackgroundTransparency={1} Size={new UDim2(1, 0, 0.75, 0)}>
									<SettingsScreen />
								</frame>
								{/* Info */}
								<Box
									BackgroundTransparency={1}
									Size={new UDim2(1, 0, 0, 0)}
									AutomaticSize={Enum.AutomaticSize.Y}
									FillDirection={Enum.FillDirection.Vertical}
									Padding={new UDim(0, 4)}
									UIPadding={6}
								>
									<Label
										BackgroundTransparency={1}
										Size={new UDim2(1, 0, 0, 0)}
										AutomaticSize={Enum.AutomaticSize.Y}
										Text={"Copy the devforum link to get this plugin:"}
										TextColor3={Theme().DimmedText}
										TextXAlignment={Enum.TextXAlignment.Left}
									/>
									<Input
										props={{
											UIStroke: {
												Transparency: 1,
											},
										}}
										BackgroundTransparency={1}
										TextEditable={false}
										Text={"https://devforum.roblox.com/t/"}
										TextColor3={Theme().DimmedText}
										Size={new UDim2(1, 0, 0, 0)}
									/>
								</Box>
							</Box>
						</frame>

						{/* Right Side */}
						<frame
							Size={createEffect(() => new UDim2(1 - SideDistribution(), 0, 1, 0))()}
							BackgroundTransparency={1}
						>
							<uistroke Thickness={3} />
							<frame
								tags={[Tags.IgnoreHoverDetection]}
								AnchorPoint={new Vector2(0.5, 1)}
								Position={new UDim2(0.5, 0, 1, -20)}
								Size={new UDim2(1, 0, 0, 20)}
								BackgroundTransparency={1}
							>
								<imagelabel
									tags={[Tags.IgnoreHoverDetection]}
									ZIndex={999}
									Image={Icons.fromName("fluency", "outline", "caret-arrow-down")}
									Size={UDim2.fromScale(1, 1)}
									AnchorPoint={new Vector2(0.5)}
									BackgroundTransparency={1}
									Position={createEffect(() => {
										return WithTransition(new UDim2(0.5, 0, 0, 0), {
											Damping: 0,
											Frequency: 2,
											DefaultValue: new UDim2(0.5, 0, 0, 5),
										});
									})}
								>
									<uiaspectratioconstraint />
								</imagelabel>
							</frame>
							<scrollingframe
								BackgroundColor3={Theme().ScrollBarBackground}
								ScrollBarImageColor3={Color3.fromRGB(0, 0, 0)}
								ScrollBarThickness={7}
								BorderSizePixel={0}
								VerticalScrollBarInset={Enum.ScrollBarInset.ScrollBar}
								Size={UDim2.fromScale(1, 1)}
								CanvasSize={new UDim2()}
								AutomaticCanvasSize={Enum.AutomaticSize.Y}
							>
								<uilistlayout FillDirection={Enum.FillDirection.Vertical} Padding={new UDim(0.5, 0)} />
								{props.children}
							</scrollingframe>
						</frame>
					</Box>
				</frame>
			</frame>
		</screengui>
	);
}

DemoUIs.GetChildren().forEach((Element) => {
	if (Element.IsA("GuiObject") === false) {
		return;
	}
	Element.Visible = true;
});
const DisplayScreenRender = <DisplayScreen>{DemoUIs.GetChildren()}</DisplayScreen>;
<RuntimeUISelectClientDemo />;

const Camera = game.Workspace.CurrentCamera!;
const ProxyMainWidget = setmetatable(
	{
		GetRelativeMousePosition: () => {
			return UserInputService.GetMouseLocation();
		},
	},
	{
		__index: (_, index) => {
			if (index === "AbsoluteSize") {
				return Camera.ViewportSize;
			}
		},
	},
);
<ToolTip Mount={DisplayScreenRender} MainWidget={ProxyMainWidget} />;
