-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
local _vivid = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out")
local Vivid = _vivid.default
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createSpring = _vivid.createSpring
local createState = _vivid.createState
local onMount = _vivid.onMount
local Collector = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "collector", "out").Collector
local RunService = game:GetService("RunService")
local createRef = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out", "create", "createRef").createRef
local _vivid_ui = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid-ui", "out")
local Theme = _vivid_ui.Theme
local Units = _vivid_ui.Units
local Constants = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Constants").Constants
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local function ToolTip(props)
	local CurrentTip, setCurrentTip, CurrentTipState = createState(nil)
	local CurrentPosition, setCurrentPosition = createState(UDim2.new())
	local ToolTipDelayValue, setToolTipDelayValue, ToolTipDelayValueState = createSpring(0)
	local LabelReference = createRef()
	onMount(function()
		local Binder = Collector:Bind(Constants.MainWidgetToolTipCollectionId, function(Object)
			local MouseEnterConnection = Object.MouseEnter:Connect(function()
				setCurrentTip(Object:GetAttribute(Constants.MainWidgetToolTipCollectionId))
			end)
			local MouseLeaveConnection = Object.MouseLeave:Connect(function()
				if CurrentTipState.State ~= Object:GetAttribute(Constants.MainWidgetToolTipCollectionId) then
					return nil
				end
				setCurrentTip(nil)
			end)
			return function()
				MouseEnterConnection:Disconnect()
				MouseLeaveConnection:Disconnect()
			end
		end)
		createCleanup(function()
			Binder:Destroy()
		end)
	end)
	onMount(function()
		createEffect(function()
			if CurrentTip() == nil or LabelReference() == nil or SettingsContext.DisableToolTips.get() == true then
				setCurrentPosition(nil)
				return nil
			end
			local Ref = LabelReference()
			local PluginMouseMoveListener = RunService.Heartbeat:Connect(function()
				local MouseRelativePosition = props.MainWidget:GetRelativeMousePosition()
				local Offset = Vector2.new(5, 10)
				local ComponentXPosition = MouseRelativePosition.X + Ref.AbsoluteSize.X + Offset.X
				local ComponentYPosition = MouseRelativePosition.Y + Ref.AbsoluteSize.Y + Offset.Y
				setCurrentPosition(UDim2.fromOffset(if ComponentXPosition > props.MainWidget.AbsoluteSize.X then props.MainWidget.AbsoluteSize.X - Ref.AbsoluteSize.X else MouseRelativePosition.X + Offset.X, if ComponentYPosition > props.MainWidget.AbsoluteSize.Y then props.MainWidget.AbsoluteSize.Y - Ref.AbsoluteSize.Y else MouseRelativePosition.Y + Offset.Y))
			end)
			createCleanup(function()
				PluginMouseMoveListener:Disconnect()
			end)
		end)
	end)
	createEffect(function()
		if CurrentTip() ~= nil then
			setToolTipDelayValue(1)
		else
			ToolTipDelayValueState.State = 0
		end
	end)
	return Vivid.createElement("textlabel", {
		ref = LabelReference,
		Name = "WidgetToolTips",
		TextWrapped = true,
		ZIndex = 99,
		BackgroundColor3 = Theme().Tooltip,
		TextColor3 = Theme().SubText,
		TextSize = function()
			return Units().BaseTextSize
		end,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.new(),
		BackgroundTransparency = 0.1,
		Text = function()
			local _condition = CurrentTip()
			if _condition == nil then
				_condition = ""
			end
			return _condition
		end,
		Position = function()
			return CurrentPosition() or UDim2.new()
		end,
		Visible = function()
			return ToolTipDelayValue() >= 1 and CurrentPosition() ~= nil and SettingsContext.DisableToolTips.get() == false
		end,
		Parent = props.Mount or props.MainWidget,
	}, Vivid.createElement("uistroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Theme().Border,
	}), Vivid.createElement("uipadding", {
		PaddingLeft = UDim.new(0, 6),
		PaddingTop = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 4),
	}), Vivid.createElement("uicorner", {
		CornerRadius = UDim.new(0, 4),
	}))
end
return {
	ToolTip = ToolTip,
}
