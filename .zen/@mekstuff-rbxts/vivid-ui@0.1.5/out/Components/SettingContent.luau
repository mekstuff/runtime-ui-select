-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:45:08
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local onMount = _vivid.onMount
local createRef = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out.create.createRef).createRef
local _Utils = TS.import(script, script.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local Label = TS.import(script, script.Parent, "Base").Label
local TextService = game:GetService("TextService")
local function SettingContentSeparatorLine(props)
	local _attributes = {
		BorderSizePixel = 0,
		BackgroundTransparency = 0.1,
		BackgroundColor3 = Theme().Border,
		Size = UDim2.new(1, 0, 0, 1),
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement("frame", _attributes)
end
local function SettingContentSeparator(props)
	local LabelRef = createRef()
	onMount(function()
		local Ref = LabelRef()
		-- Automatic sizing cause weird sizing bug, fix with custom autosize:
		local UpdateSize = function()
			local TextBoundsParams = Instance.new("GetTextBoundsParams")
			TextBoundsParams.Text = Ref.Text
			TextBoundsParams.Font = Ref.FontFace
			TextBoundsParams.Size = Ref.TextSize
			TextBoundsParams.Width = (Ref.Parent).AbsoluteSize.X * 0.5
			local TextBounds = TextService:GetTextBoundsAsync(TextBoundsParams)
			Ref.Size = UDim2.fromOffset(TextBounds.X, TextBounds.Y)
		end
		Ref:GetPropertyChangedSignal("Text"):Connect(function()
			UpdateSize()
		end)
		task.defer(function()
			-- TODO: Fix with onMount - Ref isn't parented yet, so we added this defer as a hot fix.
			UpdateSize()
		end)
	end)
	local _result = props.props
	if _result ~= nil then
		_result = _result.Container
	end
	local _attributes = {
		Visible = props.Visible,
		LayoutOrder = props.LayoutOrder,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(1, -10, 0, 0),
	}
	if _result then
		for _k, _v in _result do
			_attributes[_k] = _v
		end
	end
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.UIListLayout
	end
	local _attributes_1 = {
		Padding = UDim.new(0, 10),
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_1[_k] = _v
		end
	end
	local _exp = Vivid.createElement("uilistlayout", _attributes_1)
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.Label
	end
	local _attributes_2 = {
		ref = LabelRef,
		TextSize = function()
			return Units().BaseTextSize
		end,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		TextColor3 = Theme().DimmedText,
		Text = props.separatorText,
	}
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_2[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement(Label, _attributes_2)
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.ContentSeparatorLine
	end
	local _attributes_3 = {}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_3[_k] = _v
		end
	end
	return Vivid.createElement("frame", _attributes, _exp, _exp_1, Vivid.createElement(SettingContentSeparatorLine, _attributes_3))
end
local function SettingContent(props)
	local _result = props.props
	if _result ~= nil then
		_result = _result.Container
	end
	local _attributes = {
		Visible = props.Visible,
		LayoutOrder = props.LayoutOrder,
		BackgroundTransparency = 1,
		Size = function()
			return UDim2.new(1, 0, 0, Units().BaseOffsetHeight * 1.2)
		end,
	}
	if _result then
		for _k, _v in _result do
			_attributes[_k] = _v
		end
	end
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.ContentSeparatorLine
	end
	local _attributes_1 = {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Visible = function()
			return if props.hideSplitter then false else true
		end,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_1[_k] = _v
		end
	end
	local _exp = Vivid.createElement(SettingContentSeparatorLine, _attributes_1)
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.ContentContainer
	end
	local _attributes_2 = {
		Name = "Content",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5),
		Size = UDim2.new(1, -10, 1, -1),
	}
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_2[_k] = _v
		end
	end
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.UIPadding
	end
	local _attributes_3 = {
		PaddingLeft = UDim.new(0, 8),
		PaddingTop = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
	}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_3[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement("uipadding", _attributes_3)
	local _result_4 = props.props
	if _result_4 ~= nil then
		_result_4 = _result_4.UIListLayout
	end
	local _attributes_4 = {
		Padding = UDim.new(0, 10),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalFlex = Enum.UIFlexAlignment.Fill,
	}
	if _result_4 then
		for _k, _v in _result_4 do
			_attributes_4[_k] = _v
		end
	end
	local _exp_2 = Vivid.createElement("uilistlayout", _attributes_4)
	local _result_5 = props.props
	if _result_5 ~= nil then
		_result_5 = _result_5.TitleLabel
	end
	local _attributes_5 = {
		TextSize = function()
			return Units().BaseTextSize
		end,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Theme().SubText,
		Size = createEffect(function()
			local _condition = (props.scaleDistribution)
			if _condition == nil then
				_condition = 0.5
			end
			return UDim2.new(_condition, -5, 1, 0)
		end)(),
		Text = props.titleText,
		BackgroundTransparency = 1,
	}
	if _result_5 then
		for _k, _v in _result_5 do
			_attributes_5[_k] = _v
		end
	end
	local _exp_3 = Vivid.createElement(Label, _attributes_5)
	local _result_6 = props.props
	if _result_6 ~= nil then
		_result_6 = _result_6.RightContainer
	end
	local _attributes_6 = {
		BackgroundTransparency = 1,
		Size = createEffect(function()
			local _condition = (props.scaleDistribution)
			if _condition == nil then
				_condition = 0.5
			end
			return UDim2.new(1 - _condition, -5, 1, 0)
		end)(),
	}
	if _result_6 then
		for _k, _v in _result_6 do
			_attributes_6[_k] = _v
		end
	end
	local _result_7 = props.props
	if _result_7 ~= nil then
		_result_7 = _result_7.RightContainerUIListLayout
	end
	local _attributes_7 = {
		Padding = UDim.new(0, 5),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center,
	}
	if _result_7 then
		for _k, _v in _result_7 do
			_attributes_7[_k] = _v
		end
	end
	return Vivid.createElement("frame", _attributes, _exp, Vivid.createElement("frame", _attributes_2, _exp_1, _exp_2, _exp_3, Vivid.createElement("frame", _attributes_6, Vivid.createElement("uilistlayout", _attributes_7), props.children)))
end
return {
	SettingContentSeparator = SettingContentSeparator,
	SettingContent = SettingContent,
}
