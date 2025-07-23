-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 22:17:46
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createRef = _vivid.createRef
local createState = _vivid.createState
local onMount = _vivid.onMount
local Slot = _vivid.Slot
local _vivid_ui = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out)
local Button = _vivid_ui.Button
local Input = _vivid_ui.Input
local Label = _vivid_ui.Label
local SettingContent = _vivid_ui.SettingContent
local SettingContentSeperator = _vivid_ui.SettingContentSeperator
local Theme = _vivid_ui.Theme
local Units = _vivid_ui.Units
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local Constants = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Constants").Constants
local GetIsNonPluginEnv = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "GetUsageContext").GetIsNonPluginEnv
local ResetPluginToDefault = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "ResetPlugin").ResetPluginToDefault
local BindedSettingContextToggleSwitch = TS.import(script, script.Parent.Parent, "Components", "BindedSettingContextToggleSwitch").BindedSettingContextToggleSwitch
local HoverAccuracyInput = TS.import(script, script.Parent.Parent, "Components", "HoverAccuracyInput").HoverAccuracyInput
local ThemeToggleButton = TS.import(script, script.Parent.Parent, "Components", "ThemeToggleButton").ThemeToggleButton
local function SettingsScreen()
	local ToggleButtonOffset = 10
	local SearchRef = createRef()
	local ScrollingFrameRef = createRef()
	local SearchFilterText, setSearchFilterText = createState("")
	local SearchBoxFocused, setSearchBoxFocused = createState(false)
	local TotalSearchResults, setTotalSearchResults = createState(0)
	local SettingContentSeperatorsVisible, setSettingContentSeperatorsVisible = createState(false)
	createEffect(function()
		local SearchTextBox = SearchRef()
		if SearchTextBox == nil then
			return nil
		end
		local TextChangedListener = SearchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
			setSearchFilterText(SearchTextBox.Text)
		end)
		createCleanup(function()
			TextChangedListener:Disconnect()
		end)
	end)
	createEffect(function()
		setSettingContentSeperatorsVisible(SearchFilterText() == "")
	end)
	onMount(function()
		createEffect(function()
			local ScrollingFrame = ScrollingFrameRef()
			if ScrollingFrame == nil then
				return nil
			end
			local SearchFilter = SearchFilterText()
			setTotalSearchResults(0)
			local TotalSearchResults = 0
			local _exp = ScrollingFrame:GetChildren()
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(Child)
				if Child:IsA("GuiObject") ~= true then
					return nil
				end
				local SearchFilterMatchAttribute = Child:GetAttribute(Constants.SearchFilterMatchAttribute)
				if type(SearchFilterMatchAttribute) == "string" ~= true then
					return nil
				end
				local _exp_1 = string.lower(SearchFilterMatchAttribute)
				local _arg0 = string.lower(SearchFilter)
				local Match = (string.match(_exp_1, _arg0))
				Child.Visible = Match ~= nil
				if Child.Visible == true then
					TotalSearchResults += 1
				end
			end
			for _k, _v in _exp do
				_callback(_v, _k - 1, _exp)
			end
			-- ▲ ReadonlyArray.forEach ▲
			setTotalSearchResults(TotalSearchResults)
		end)
	end)
	return Vivid.createElement("frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme().MainBackground,
	}, Vivid.createElement(Slot, {
		slotId = "#root",
	}), Vivid.createElement(Label, {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		TextWrapped = true,
		Text = createEffect(function()
			return `No results for "{SearchFilterText()}"`
		end)(),
		TextColor3 = Theme().DimmedText,
		Visible = createEffect(function()
			return TotalSearchResults() == 0
		end),
		ZIndex = 2,
	}), Vivid.createElement("scrollingframe", {
		ref = ScrollingFrameRef,
		Size = createEffect(function()
			return UDim2.new(1, 0, 1, -(Units().BaseOffsetHeight + ToggleButtonOffset * 2))
		end)(),
		BackgroundColor3 = Theme().ScrollBarBackground,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = Theme().ScrollBar,
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		BorderSizePixel = 0,
	}, Vivid.createElement("uilistlayout", {
		FillDirection = Enum.FillDirection.Vertical,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
	}), Vivid.createElement("uipadding", {
		PaddingLeft = UDim.new(0, 4),
		PaddingTop = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
	}), Vivid.createElement("frame", {
		Size = UDim2.new(1, 0, 0, 4),
		BackgroundTransparency = 1,
	}), Vivid.createElement(Input, {
		ref = SearchRef,
		props = {
			UIStroke = {
				Color = createEffect(function()
					return if SearchBoxFocused() then Theme().MainButton else Theme().InputFieldBorder
				end),
			},
		},
		Focused = function()
			return setSearchBoxFocused(true)
		end,
		FocusLost = function()
			return setSearchBoxFocused(false)
		end,
		Text = SearchFilterText(),
		PlaceholderText = "Filter...",
		Size = createEffect(function()
			return UDim2.new(1, 0, 0, Units().BaseOffsetHeight * 0.9)
		end)(),
		AutomaticSize = Enum.AutomaticSize.None,
	}), Vivid.createElement("frame", {
		Size = UDim2.new(1, 0, 0, 8),
		BackgroundTransparency = 1,
	}), Vivid.createElement(SettingContentSeperator, {
		seperatorText = "Hovering",
		Visible = SettingContentSeperatorsVisible(),
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Hover Detection Enabled",
		TargetSettingContext = "HoverDetectionEnabled",
		ToolTip = "Enables the ability for the plugin to detect what items are being hovered during runtime.",
		Dependencies = { "PluginEnabled" },
	}), Vivid.createElement("frame", {
		attributes = {
			[Constants.SearchFilterMatchAttribute] = "Hover Detection Accuracy",
		},
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
	}, Vivid.createElement(SettingContent, {
		titleText = "Hover Detection Accuracy",
		scaleDistribution = 0.85,
	}, Vivid.createElement(HoverAccuracyInput))), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Allow Multi-Hover Detection",
		TargetSettingContext = "MultiHoverDetectionEnabled",
		ToolTip = "Enables the ability for the plugin to detect multiple items being hovered during runtime, This may not be ideal for compacted GUI.",
		Dependencies = { "HoverDetectionEnabled" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show Instance Name On Hover",
		TargetSettingContext = "ShowInstanceNameOnHover",
		ToolTip = "Will show the Name property of the hovered items.",
		Dependencies = { "HoverDetectionEnabled" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Ctrl/Cmd Key Required For Hover Detection",
		TargetSettingContext = "UseHoverDetectionActivationKeybind",
		ToolTip = "Requires the CTRL/CMD key to be pressed for hover detection to be enabled.",
		Dependencies = { "HoverDetectionEnabled" },
	}), Vivid.createElement(SettingContentSeperator, {
		seperatorText = "Hover Dimensions",
		Visible = SettingContentSeperatorsVisible(),
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show Dimensions On Hover",
		TargetSettingContext = "ShowDimensionsOnHover",
		ToolTip = "Enables the ability for the plugin to show dimension values of items that are hovered.",
		Dependencies = { "HoverDetectionEnabled" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show AbsoluteSize On Hover",
		TargetSettingContext = "ShowAbsoluteSizeOnHover",
		ToolTip = "Will show the AbsoluteSize property of the hovered items.",
		Dependencies = { "ShowDimensionsOnHover" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show AbsolutePosition On Hover",
		TargetSettingContext = "ShowAbsolutePositionOnHover",
		ToolTip = "Will show the AbsolutePosition property of the hovered items.",
		Dependencies = { "ShowDimensionsOnHover" },
	}), Vivid.createElement(SettingContentSeperator, {
		seperatorText = "Distance Indicators",
		Visible = SettingContentSeperatorsVisible(),
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show Distance Indicators On Hover",
		TargetSettingContext = "ShowBorderBoxesOnHover",
		ToolTip = "Will show the distance between the Component and it's Parent component.",
		Dependencies = { "HoverDetectionEnabled" },
		InverseDependencies = { "MultiHoverDetectionEnabled" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show Left Distance Indicator",
		TargetSettingContext = "ShowLeftBorderBox",
		Dependencies = { "ShowBorderBoxesOnHover" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show Top Distance Indicator",
		TargetSettingContext = "ShowTopBorderBox",
		Dependencies = { "ShowBorderBoxesOnHover" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show Right Distance Indicator",
		TargetSettingContext = "ShowRightBorderBox",
		Dependencies = { "ShowBorderBoxesOnHover" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Show Bottom Distance Indicator",
		TargetSettingContext = "ShowBottomBorderBox",
		Dependencies = { "ShowBorderBoxesOnHover" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Distance Indicators Are Always Relative To Viewport",
		TargetSettingContext = "CalculateBorderBoxRelativeToViewport",
		Dependencies = { "ShowBorderBoxesOnHover" },
	}), Vivid.createElement(SettingContentSeperator, {
		seperatorText = "Behavior",
		Visible = SettingContentSeperatorsVisible(),
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Left Click To Select GUI",
		TargetSettingContext = "AllowUserRuntimeUISelection",
		ToolTip = "Enables the ability for the plugin to allow the user to select hovered UI during runtime.",
		Dependencies = { "HoverDetectionEnabled" },
		UnavailableFeature = GetIsNonPluginEnv(),
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Right Click For Context Menu",
		TargetSettingContext = "RightClickForContextMenu",
		ToolTip = "Right click during runtime for a context menu.\n\nIf you have a hover detect activation keybind, You will need to be holding the key.",
		Dependencies = { "HoverDetectionEnabled" },
		UnavailableFeature = GetIsNonPluginEnv(),
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Block Input Activations",
		TargetSettingContext = "BlockButtonActivations",
		ToolTip = "Will block any input activations, allowing you to select buttons/textboxes during runtime without firing any events.",
		Dependencies = { "PluginEnabled", "UseHoverDetectionActivationKeybind" },
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Ignore Transparent GUI Objects",
		TargetSettingContext = "IgnoreTransparentGUIObjects",
		ToolTip = "Will ignore GUI Objects that are transparent.",
		Dependencies = { "PluginEnabled" },
	}), Vivid.createElement(SettingContentSeperator, {
		seperatorText = "Plugin",
		Visible = SettingContentSeperatorsVisible(),
	}), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Detect Runtime Settings Changes",
		TargetSettingContext = "DetectRuntimeSettingsChanges",
		ToolTip = "Whenever you make a plugin setting change during runtime, You will be prompted to save the changes when you exit the session.\n\nOnce enabled, whenever you make a setting change and leave the game, Roblox will prompt you that you've made some script changes, You must select yes at this step.\n\nNOTE: You may experience a flicker whenever the first setting is changed during runtime.",
		Dependencies = { "PluginEnabled" },
		UnavailableFeature = GetIsNonPluginEnv(),
	}), Vivid.createElement("frame", {
		attributes = {
			[Constants.SearchFilterMatchAttribute] = "Studio Theme",
		},
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
	}, Vivid.createElement(SettingContent, {
		titleText = "Studio Theme",
		scaleDistribution = 0.75,
	}, Vivid.createElement(ThemeToggleButton))), Vivid.createElement(BindedSettingContextToggleSwitch, {
		Text = "Disable Tooltips",
		TargetSettingContext = "DisableToolTips",
		ToolTip = "Disables this.",
	}), Vivid.createElement("frame", {
		attributes = {
			[Constants.SearchFilterMatchAttribute] = "Reset To Default",
		},
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
	}, Vivid.createElement(SettingContent, {
		titleText = "Reset To Default",
		scaleDistribution = 0.75,
	}, Vivid.createElement(Button, {
		Size = UDim2.fromScale(1, 0),
		Text = "Reset",
		Activated = function()
			ResetPluginToDefault()
		end,
	}))), Vivid.createElement("frame", {
		attributes = {
			[Constants.SearchFilterMatchAttribute] = "Version",
		},
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
	}, Vivid.createElement(SettingContent, {
		titleText = "Version",
		scaleDistribution = 0.8,
	}, Vivid.createElement(Label, {
		TextColor3 = Theme().DimmedText,
		Text = Constants.PluginVersion,
	})))), Vivid.createElement(Button, {
		color = createEffect(function()
			return if SettingsContext.PluginEnabled.get() == false then "primary" else "default"
		end)(),
		padding = 6,
		Activated = function()
			return SettingsContext.PluginEnabled.set(function(old)
				local TargetState = not old
				return TargetState
			end)
		end,
		Position = UDim2.new(0.5, 0, 1, -ToggleButtonOffset),
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.fromScale(0.95),
		Text = createEffect(function()
			return if SettingsContext.PluginEnabled.get() then "Disable" else "Enable"
		end)(),
	}))
end
return {
	SettingsScreen = SettingsScreen,
}
