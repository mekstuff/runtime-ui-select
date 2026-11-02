/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:17:46
*/

import Vivid, { createCleanup, createEffect, createRef, createState, onMount, Slot } from "@mekstuff-rbxts/vivid";
import { Button, Input, Label, SettingContent, SettingContentSeparator, Theme, Units } from "@mekstuff-rbxts/vivid-ui";
SettingContentSeparator;
import { SettingsContext } from "Contexts/SettingsContexts";
import { Constants } from "Core/Constants/Constants";
import { GetIsNonPluginEnv } from "Core/Functions/GetUsageContext";
import { ResetPluginToDefault } from "Core/Functions/ResetPlugin";
import { BindedSettingContextToggleSwitch } from "UI/Components/BindedSettingContextToggleSwitch";
import { HoverAccuracyInput } from "UI/Components/HoverAccuracyInput";
import { ThemeToggleButton } from "UI/Components/ThemeToggleButton";

export function SettingsScreen() {
	const ToggleButtonOffset = 10;

	const SearchRef = createRef<TextBox>();
	const ScrollingFrameRef = createRef<ScrollingFrame>();

	const [SearchFilterText, setSearchFilterText] = createState("");
	const [SearchBoxFocused, setSearchBoxFocused] = createState(false);
	const [TotalSearchResults, setTotalSearchResults] = createState(0);
	const [SettingContentSeparatorsVisible, setSettingContentSeparatorsVisible] = createState(false);

	createEffect(() => {
		const SearchTextBox = SearchRef();
		if (SearchTextBox === undefined) {
			return;
		}
		const TextChangedListener = SearchTextBox.GetPropertyChangedSignal("Text").Connect(() => {
			setSearchFilterText(SearchTextBox.Text);
		});
		createCleanup(() => {
			TextChangedListener.Disconnect();
		});
	});

	createEffect(() => {
		setSettingContentSeparatorsVisible(SearchFilterText() === "");
	});

	onMount(() => {
		createEffect(() => {
			const ScrollingFrame = ScrollingFrameRef();
			if (ScrollingFrame === undefined) {
				return;
			}
			const SearchFilter = SearchFilterText();
			setTotalSearchResults(0);
			let TotalSearchResults = 0;
			ScrollingFrame.GetChildren().forEach((Child) => {
				if (Child.IsA("GuiObject") !== true) {
					return;
				}
				const SearchFilterMatchAttribute = Child.GetAttribute(Constants.SearchFilterMatchAttribute);
				if (typeIs(SearchFilterMatchAttribute, "string") !== true) {
					return;
				}
				const Match = SearchFilterMatchAttribute.lower().match(SearchFilter.lower())[0];
				Child.Visible = Match !== undefined;
				if (Child.Visible === true) {
					TotalSearchResults += 1;
				}
			});
			setTotalSearchResults(TotalSearchResults);
		});
	});

	return (
		<frame Size={UDim2.fromScale(1, 1)} BackgroundColor3={Theme().MainBackground}>
			<Slot slotId="#root"></Slot>
			<Label
				Size={UDim2.fromScale(1, 1)}
				BackgroundTransparency={1}
				TextWrapped={true}
				Text={createEffect(() => {
					return `No results for "${SearchFilterText()}"`;
				})()}
				TextColor3={Theme().DimmedText}
				Visible={createEffect(() => {
					return TotalSearchResults() === 0;
				})}
				ZIndex={2}
			/>
			<scrollingframe
				ref={ScrollingFrameRef}
				Size={createEffect(() => new UDim2(1, 0, 1, -(Units().BaseOffsetHeight + ToggleButtonOffset * 2)))()}
				BackgroundColor3={Theme().ScrollBarBackground}
				CanvasSize={new UDim2()}
				AutomaticCanvasSize={Enum.AutomaticSize.Y}
				ScrollBarThickness={6}
				ScrollBarImageColor3={Theme().ScrollBar}
				VerticalScrollBarInset={Enum.ScrollBarInset.ScrollBar}
				BorderSizePixel={0}
			>
				<uilistlayout
					FillDirection={Enum.FillDirection.Vertical}
					HorizontalAlignment={Enum.HorizontalAlignment.Center}
				/>
				<uipadding
					PaddingLeft={new UDim(0, 4)}
					PaddingTop={new UDim(0, 4)}
					PaddingRight={new UDim(0, 4)}
					PaddingBottom={new UDim(0, 4)}
				/>

				<frame Size={new UDim2(1, 0, 0, 4)} BackgroundTransparency={1} />
				<Input
					ref={SearchRef}
					props={{
						UIStroke: {
							Color: createEffect(() =>
								SearchBoxFocused() ? Theme().MainButton : Theme().InputFieldBorder,
							),
						},
					}}
					Focused={() => setSearchBoxFocused(true)}
					FocusLost={() => setSearchBoxFocused(false)}
					Text={SearchFilterText()}
					PlaceholderText={"Filter..."}
					Size={createEffect(() => new UDim2(1, 0, 0, Units().BaseOffsetHeight * 0.9))()}
					AutomaticSize={Enum.AutomaticSize.None}
				/>
				<frame Size={new UDim2(1, 0, 0, 8)} BackgroundTransparency={1} />

				{/* Hovering */}
				<SettingContentSeparator separatorText={"Hovering"} Visible={SettingContentSeparatorsVisible()} />
				<BindedSettingContextToggleSwitch
					Text="Hover Detection Enabled"
					TargetSettingContext="HoverDetectionEnabled"
					ToolTip="Enables the ability for the plugin to detect what items are being hovered during runtime."
					Dependencies={["PluginEnabled"]}
				/>
				<frame
					attributes={{
						[Constants.SearchFilterMatchAttribute]: "Hover Detection Accuracy",
					}}
					AutomaticSize={Enum.AutomaticSize.XY}
					BackgroundTransparency={1}
				>
					<SettingContent titleText={"Hover Detection Accuracy"} scaleDistribution={0.85}>
						<HoverAccuracyInput />
					</SettingContent>
				</frame>
				<BindedSettingContextToggleSwitch
					Text="Allow Multi-Hover Detection"
					TargetSettingContext="MultiHoverDetectionEnabled"
					ToolTip="Enables the ability for the plugin to detect multiple items being hovered during runtime, This may not be ideal for compacted GUI."
					Dependencies={["HoverDetectionEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Instance Name On Hover"
					TargetSettingContext="ShowInstanceNameOnHover"
					ToolTip="Will show the Name property of the hovered items."
					Dependencies={["HoverDetectionEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Ctrl/Cmd Key Required For Hover Detection"
					TargetSettingContext="UseHoverDetectionActivationKeybind"
					ToolTip="Requires the CTRL/CMD key to be pressed for hover detection to be enabled."
					Dependencies={["HoverDetectionEnabled"]}
				/>
				{/* Hover Dimensions */}
				<SettingContentSeparator
					separatorText={"Hover Dimensions"}
					Visible={SettingContentSeparatorsVisible()}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Dimensions On Hover"
					TargetSettingContext="ShowDimensionsOnHover"
					ToolTip="Enables the ability for the plugin to show dimension values of items that are hovered."
					Dependencies={["HoverDetectionEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show AbsoluteSize On Hover"
					TargetSettingContext="ShowAbsoluteSizeOnHover"
					ToolTip="Will show the AbsoluteSize property of the hovered items."
					Dependencies={["ShowDimensionsOnHover"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show AbsolutePosition On Hover"
					TargetSettingContext="ShowAbsolutePositionOnHover"
					ToolTip="Will show the AbsolutePosition property of the hovered items."
					Dependencies={["ShowDimensionsOnHover"]}
				/>

				{/* Selecting */}
				{/* <SettingContentSeparator separatorText={"Selecting"} Visible={SettingContentSeparatorsVisible()} />
				<BindedSettingContextToggleSwitch
					Text="Selected Detection Enabled"
					TargetSettingContext="SelectedDetectionEnabled"
					Dependencies={["PluginEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Dimensions On Selected"
					TargetSettingContext="ShowDimensionsOnSelected"
					Dependencies={["SelectedDetectionEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show AbsoluteSize On Selected"
					TargetSettingContext="ShowAbsoluteSizeOnSelected"
					Dependencies={["ShowDimensionsOnSelected"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Instance Name On Selected"
					TargetSettingContext="ShowInstanceNameOnSelected"
					Dependencies={["PluginEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show AbsolutePosition On Selected"
					TargetSettingContext="ShowAbsolutePositionOnSelected"
					Dependencies={["ShowDimensionsOnSelected"]}
				/> */}

				{/* BorderBoxes / Distance Indicators */}
				<SettingContentSeparator
					separatorText={"Distance Indicators"}
					Visible={SettingContentSeparatorsVisible()}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Distance Indicators On Hover"
					TargetSettingContext="ShowBorderBoxesOnHover"
					ToolTip="Will show the distance between the Component and it's Parent component."
					Dependencies={["HoverDetectionEnabled"]}
					InverseDependencies={["MultiHoverDetectionEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Left Distance Indicator"
					TargetSettingContext="ShowLeftBorderBox"
					Dependencies={["ShowBorderBoxesOnHover"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Top Distance Indicator"
					TargetSettingContext="ShowTopBorderBox"
					Dependencies={["ShowBorderBoxesOnHover"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Right Distance Indicator"
					TargetSettingContext="ShowRightBorderBox"
					Dependencies={["ShowBorderBoxesOnHover"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Show Bottom Distance Indicator"
					TargetSettingContext="ShowBottomBorderBox"
					Dependencies={["ShowBorderBoxesOnHover"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Distance Indicators Are Always Relative To Viewport"
					TargetSettingContext="CalculateBorderBoxRelativeToViewport"
					Dependencies={["ShowBorderBoxesOnHover"]}
				/>

				{/* 3D */}
				{/* <SettingContentSeparator separatorText={"3D"} Visible={SettingContentSeparatorsVisible()} />
				<BindedSettingContextToggleSwitch
					Text="Detect GuiObjects in World"
					TargetSettingContext="DetectGuiObjectsIn3DWorld"
					ToolTip="Detects GuiObjects within 3D world, For example, SurfaceGui's that aren't using Adornee and Decals."
					Dependencies={["HoverDetectionEnabled"]}
					UnavailableFeature={GetIsNonPluginEnv()}
				/> */}

				<SettingContentSeparator separatorText={"Behavior"} Visible={SettingContentSeparatorsVisible()} />
				{/* Behavior */}
				<BindedSettingContextToggleSwitch
					Text="Left Click To Select GUI"
					TargetSettingContext="AllowUserRuntimeUISelection"
					ToolTip="Enables the ability for the plugin to allow the user to select hovered UI during runtime."
					Dependencies={["HoverDetectionEnabled"]}
					UnavailableFeature={GetIsNonPluginEnv()}
				/>
				<BindedSettingContextToggleSwitch
					Text="Right Click For Context Menu"
					TargetSettingContext="RightClickForContextMenu"
					ToolTip="Right click during runtime for a context menu.\n\nIf you have a hover detect activation keybind, You will need to be holding the key."
					Dependencies={["HoverDetectionEnabled"]}
					UnavailableFeature={GetIsNonPluginEnv()}
				/>
				<BindedSettingContextToggleSwitch
					Text="Block Input Activations"
					TargetSettingContext="BlockButtonActivations"
					ToolTip="Will block any input activations, allowing you to select buttons/textboxes during runtime without firing any events."
					Dependencies={["PluginEnabled", "UseHoverDetectionActivationKeybind"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Ignore Transparent GUI Objects"
					TargetSettingContext="IgnoreTransparentGUIObjects"
					ToolTip="Will ignore GUI Objects that are transparent."
					Dependencies={["PluginEnabled"]}
				/>

				{/* Plugin */}
				<SettingContentSeparator separatorText={"Plugin"} Visible={SettingContentSeparatorsVisible()} />
				<BindedSettingContextToggleSwitch
					Text="Detect Runtime Settings Changes"
					TargetSettingContext="DetectRuntimeSettingsChanges"
					ToolTip="Whenever you make a plugin setting change during runtime, You will be prompted to save the changes when you exit the session.\n\nOnce enabled, whenever you make a setting change and leave the game, Roblox will prompt you that you've made some script changes, You must select yes at this step.\n\nNOTE: You may experience a flicker whenever the first setting is changed during runtime."
					Dependencies={["PluginEnabled"]}
					UnavailableFeature={GetIsNonPluginEnv()}
				/>
				<frame
					attributes={{
						[Constants.SearchFilterMatchAttribute]: "Studio Theme",
					}}
					AutomaticSize={Enum.AutomaticSize.XY}
					BackgroundTransparency={1}
				>
					<SettingContent titleText={"Studio Theme"} scaleDistribution={0.75}>
						<ThemeToggleButton />
					</SettingContent>
				</frame>
				<BindedSettingContextToggleSwitch
					Text="Disable Tooltips"
					TargetSettingContext="DisableToolTips"
					ToolTip="Disables this."
				/>
				<frame
					attributes={{
						[Constants.SearchFilterMatchAttribute]: "Reset To Default",
					}}
					AutomaticSize={Enum.AutomaticSize.XY}
					BackgroundTransparency={1}
				>
					<SettingContent titleText={"Reset To Default"} scaleDistribution={0.75}>
						<Button
							Size={UDim2.fromScale(1, 0)}
							Text={"Reset"}
							Activated={() => {
								ResetPluginToDefault();
							}}
						/>
					</SettingContent>
				</frame>
				<frame
					attributes={{
						[Constants.SearchFilterMatchAttribute]: "Version",
					}}
					AutomaticSize={Enum.AutomaticSize.XY}
					BackgroundTransparency={1}
				>
					<SettingContent titleText={"Version"} scaleDistribution={0.8}>
						<Label TextColor3={Theme().DimmedText} Text={Constants.PluginVersion} />
					</SettingContent>
				</frame>
			</scrollingframe>
			<Button
				color={createEffect(() => (SettingsContext.PluginEnabled.get() === false ? "primary" : "default"))()}
				padding={6}
				Activated={() =>
					SettingsContext.PluginEnabled.set((old) => {
						const TargetState = !old;
						return TargetState;
					})
				}
				Position={new UDim2(0.5, 0, 1, -ToggleButtonOffset)}
				AnchorPoint={new Vector2(0.5, 1)}
				Size={UDim2.fromScale(0.95)}
				Text={createEffect(() => (SettingsContext.PluginEnabled.get() ? "Disable" : "Enable"))()}
			/>
		</frame>
	);
}
