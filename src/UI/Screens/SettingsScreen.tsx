/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:17:46
*/

import Vivid, { createEffect, Slot } from "@mekstuff-rbxts/vivid";
import { Button, SettingContent, SettingContentSeperator, Theme, Units } from "@mekstuff-rbxts/vivid-ui";
import { SettingsContext } from "Contexts/SettingsContexts";
import { ResetPluginToDefault } from "Core/Functions/ResetPlugin";
import { BindedSettingContextToggleSwitch } from "UI/Components/BindedSettingContextToggleSwitch";
import { ThemeToggleButton } from "UI/Components/ThemeToggleButton";

export function SettingsScreen() {
	const ToggleButtonOffset = 10;
	return (
		<frame Size={UDim2.fromScale(1, 1)} BackgroundTransparency={1}>
			<Slot slotId="#root"></Slot>
			<scrollingframe
				Size={createEffect(() => new UDim2(1, 0, 1, -(Units().BaseOffsetHeight + ToggleButtonOffset * 2)))()}
				BackgroundColor3={Theme().ScrollBarBackground}
				CanvasSize={new UDim2()}
				AutomaticCanvasSize={Enum.AutomaticSize.Y}
				ScrollBarThickness={6}
				ScrollBarImageColor3={Theme().ScrollBar}
				VerticalScrollBarInset={Enum.ScrollBarInset.ScrollBar}
				BorderSizePixel={0}
			>
				<uilistlayout FillDirection={Enum.FillDirection.Vertical} />
				<uipadding
					PaddingLeft={new UDim(0, 4)}
					PaddingTop={new UDim(0, 4)}
					PaddingRight={new UDim(0, 4)}
					PaddingBottom={new UDim(0, 4)}
				/>

				{/* Hovering */}
				<SettingContentSeperator seperatorText={"Hovering"} />
				<BindedSettingContextToggleSwitch
					Text="Hover Detection Enabled"
					TargetSettingContext="HoverDetectionEnabled"
					ToolTip="Enables the ability for the plugin to detect what items are being hovered during runtime."
					Dependencies={["PluginEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Allow Multi-Hover Detection"
					TargetSettingContext="MultiHoverDetectionEnabled"
					ToolTip="Enables the ability for the plugin to detect multiple items being hovered during runtime, This may not be ideal for compacted GUI."
					Dependencies={["HoverDetectionEnabled"]}
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
				<BindedSettingContextToggleSwitch
					Text="Show Instance Name On Hover"
					TargetSettingContext="ShowInstanceNameOnHover"
					ToolTip="Will show the Name property of the hovered items."
					Dependencies={["PluginEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Ctrl/Cmd Key Required For Hover Detection"
					TargetSettingContext="UseHoverDetectionActivationKeybind"
					ToolTip="Requires the CTRL/CMD key to be pressed for hover detection to be enabled."
					Dependencies={["PluginEnabled"]}
				/>

				{/* Selecting */}
				{/* <SettingContentSeperator seperatorText={"Selecting"} />
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

				{/* Behavior */}
				<SettingContentSeperator seperatorText={"Behavior"} />
				<BindedSettingContextToggleSwitch
					Text="Allow Runtime GUI Selection"
					TargetSettingContext="AllowUserRuntimeUISelection"
					ToolTip="Enables the ability for the plugin to allow the user to select hovered UI during runtime."
					Dependencies={["HoverDetectionEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Ignore Transparent GUI Objects"
					TargetSettingContext="IgnoreTransparentGUIObjects"
					ToolTip="Will ignore GUI Objects that are transparent."
					Dependencies={["PluginEnabled"]}
				/>
				<BindedSettingContextToggleSwitch
					Text="Block Input Activations"
					TargetSettingContext="BlockButtonActivations"
					ToolTip="Will block any input activations, allowing you to select buttons/textboxes during runtime without firing any events."
					Dependencies={["PluginEnabled"]}
				/>

				{/* Plugin */}
				<SettingContentSeperator seperatorText={"Plugin"} />
				<BindedSettingContextToggleSwitch
					Text="Detect Runtime Settings Changes"
					TargetSettingContext="DetectRuntimeSettingsChanges"
					ToolTip="Whenever you make a plugin setting change during runtime, You will be prompted to save the changes when you exit the session.\n\nOnce enabled, whenever you make a setting change and leave the game, Roblox will prompt you that you've made some script changes, You must select yes at this step.\n\nNOTE: You may experience a flicker whenever the first setting is changed during runtime."
					Dependencies={["PluginEnabled"]}
				/>
				<SettingContent titleText={"Studio Theme"} scaleDistribution={0.5}>
					<ThemeToggleButton />
				</SettingContent>
				<BindedSettingContextToggleSwitch
					Text="Disable Tooltips"
					TargetSettingContext="DisableToolTips"
					ToolTip="Disables this."
				/>
				<SettingContent titleText={"Reset To Default"} scaleDistribution={0.5}>
					<Button
						Size={UDim2.fromScale(1, 0)}
						Text={"Reset"}
						Activated={() => {
							ResetPluginToDefault();
						}}
					/>
				</SettingContent>
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
