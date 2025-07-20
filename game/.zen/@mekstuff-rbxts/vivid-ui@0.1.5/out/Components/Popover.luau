-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    11/06/2025 14:05:34
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createRef = _vivid.createRef
local createState = _vivid.createState
local Modal = TS.import(script, script.Parent, "Base").Modal
local extp = TS.import(script, script.Parent.Parent, "Utils").extp
local function Popover(props)
	-- const Properties = withProps(props, true) as Partial<typeof props>;
	local ModalContainerRef = createRef()
	local TargetPosition, setTargetPosition = createState(UDim2.new())
	local ContainerTargetPosition, setContainerTargetPosition = createState(nil)
	createEffect(function()
		local _result
		if props.hideArrow == true then
			_result = TargetPosition()
		else
			local _result_1 = TargetPosition()
			if _result_1 ~= nil then
				local _arg0 = UDim2.fromOffset(0, if props.verticalAlignment == Enum.VerticalAlignment.Top then -5 elseif props.verticalAlignment == Enum.VerticalAlignment.Bottom then 5 else 0)
				_result_1 = _result_1 + _arg0
			end
			_result = _result_1
		end
		local _result_1 = _result
		if _result_1 ~= nil then
			local _arg0 = props.offset or UDim2.new()
			_result_1 = _result_1 + _arg0
		end
		setContainerTargetPosition(_result_1)
	end)
	createEffect(function()
		-- deps
		local ContainerRef = ModalContainerRef()
		if props.adornee == nil or ContainerRef == nil then
			setTargetPosition(nil)
			return nil
		end
		local AdorneeObject = props.adornee
		local Update = function()
			local AdorneeAbsPos = AdorneeObject.AbsolutePosition
			local AdorneeAbsSize = AdorneeObject.AbsoluteSize
			local ContainerRefAbsSize = ContainerRef.AbsoluteSize
			local CenteredXAxis = AdorneeAbsPos.X / ContainerRefAbsSize.X + ContainerRefAbsSize.X * 0.5
			local CenteredYAxis = AdorneeAbsPos.Y - ContainerRefAbsSize.Y - AdorneeAbsSize.Y
			local XPos = if props.horizontalAlignment == Enum.HorizontalAlignment.Left then CenteredXAxis - ContainerRefAbsSize.X * 0.5 elseif props.horizontalAlignment == Enum.HorizontalAlignment.Right then CenteredXAxis + ContainerRefAbsSize.X * 0.5 else CenteredXAxis
			local YPos = if props.verticalAlignment == Enum.VerticalAlignment.Top then CenteredYAxis - ContainerRefAbsSize.Y elseif props.verticalAlignment == Enum.VerticalAlignment.Bottom then CenteredYAxis + ContainerRefAbsSize.Y else CenteredYAxis
			setTargetPosition(UDim2.fromOffset(XPos, YPos))
		end
		local AbsPosListener = AdorneeObject:GetPropertyChangedSignal("AbsolutePosition"):Connect(Update)
		local AbsSizeListener = AdorneeObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)
		local ContainerAbsSizeListener = ContainerRef:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)
		createCleanup(function()
			AbsPosListener:Disconnect()
			AbsSizeListener:Disconnect()
			ContainerAbsSizeListener:Disconnect()
		end)
		Update()
	end)
	local _attributes = {
		opened = props.opened,
		scale = props.scale,
		backdropTransparency = props.backdropTransparency,
		openedPosition = ContainerTargetPosition(),
		closedPosition = ContainerTargetPosition(),
	}
	local _exp = {
		Container = {
			ref = ModalContainerRef,
			AnchorPoint = Vector2.new(),
			AutomaticSize = Enum.AutomaticSize.XY,
		},
	}
	local _result = props.props
	if _result ~= nil then
		_result = _result.Modal
	end
	_attributes.props = extp(_exp, _result)
	return Vivid.createElement("folder", nil, Vivid.createElement(Modal, _attributes, props.children))
end
return {
	Popover = Popover,
}
