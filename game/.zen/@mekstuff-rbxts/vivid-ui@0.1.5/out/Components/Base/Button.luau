-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:35:43
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local withProps = _vivid.withProps
local _Utils = TS.import(script, script.Parent.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local Spinner = TS.import(script, script.Parent, "Spinner").Spinner
local Label = TS.import(script, script.Parent, "Label").Label
local function Button(props)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.children = nil
	Properties.roundness = nil
	Properties.padding = nil
	Properties.icon = nil
	Properties.loading = nil
	Properties.color = nil
	Properties.variant = nil
	Properties.disabled = nil
	Properties.Text = nil
	Properties.TextScaled = nil
	Properties.TextTruncate = nil
	Properties.TextXAlignment = nil
	Properties.TextYAlignment = nil
	Properties.RichText = nil
	Properties.TextTransparency = nil
	Properties.TextWrapped = nil
	local _attributes = {}
	local _condition = props.AutoButtonColor
	if _condition == nil then
		_condition = (function()
			return if props.disabled then false else true
		end)
	end
	_attributes.AutoButtonColor = _condition
	_attributes.BorderSizePixel = 0
	_attributes.BackgroundTransparency = function()
		return if props.variant == "outlined" or props.variant == "ghost" then 1 else 0
	end
	_attributes.BackgroundColor3 = function()
		if props.disabled == true then
			return Theme().DimmedText
		end
		if props.color == "primary" then
			return Theme().MainButton
		end
		if props.color == "danger" then
			return Theme().ErrorText
		end
		if props.color == "success" then
			return Theme().MainButton
		end
		return Theme().Button
	end
	_attributes.AutomaticSize = Enum.AutomaticSize.XY
	_attributes.Text = ""
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	local _result = props.props
	if _result ~= nil then
		_result = _result.UIPadding
	end
	local _attributes_1 = {
		PaddingLeft = function()
			local _value = props.padding
			if _value ~= 0 and _value == _value and _value then
				local _padding = props.padding
				if type(_padding) == "number" then
					return UDim.new(0, props.padding)
				end
				local _padding_1 = props.padding
				if type(_padding_1) == "table" then
					return (props.padding)[1]
				end
			end
			return UDim.new(0, 4)
		end,
		PaddingTop = function()
			local _value = props.padding
			if _value ~= 0 and _value == _value and _value then
				local _padding = props.padding
				if type(_padding) == "number" then
					return UDim.new(0, props.padding)
				end
				local _padding_1 = props.padding
				if type(_padding_1) == "table" then
					return (props.padding)[2]
				end
			end
			return UDim.new(0, 2)
		end,
		PaddingRight = function()
			local _value = props.padding
			if _value ~= 0 and _value == _value and _value then
				local _padding = props.padding
				if type(_padding) == "number" then
					return UDim.new(0, props.padding)
				end
				local _padding_1 = props.padding
				if type(_padding_1) == "table" then
					return (props.padding)[3]
				end
			end
			return UDim.new(0, 4)
		end,
		PaddingBottom = function()
			local _value = props.padding
			if _value ~= 0 and _value == _value and _value then
				local _padding = props.padding
				if type(_padding) == "number" then
					return UDim.new(0, props.padding)
				end
				local _padding_1 = props.padding
				if type(_padding_1) == "table" then
					return (props.padding)[4]
				end
			end
			return UDim.new(0, 2)
		end,
	}
	if _result then
		for _k, _v in _result do
			_attributes_1[_k] = _v
		end
	end
	local _exp = Vivid.createElement("uipadding", _attributes_1)
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.UIListLayout
	end
	local _attributes_2 = {
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Padding = UDim.new(0, 6),
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement("uilistlayout", _attributes_2)
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.IconImage
	end
	local _attributes_3 = {
		LayoutOrder = 1,
		Visible = function()
			if props.icon == "" or props.icon == nil then
				return false
			end
			return true
		end,
		Size = function()
			local _condition_1 = (props.TextSize)
			if _condition_1 == nil then
				_condition_1 = Units().BaseTextSize + 5
			end
			local _condition_2 = (props.TextSize)
			if _condition_2 == nil then
				_condition_2 = Units().BaseTextSize + 5
			end
			return UDim2.fromOffset(_condition_1, _condition_2)
		end,
		BackgroundTransparency = 1,
		Image = props.icon,
	}
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_3[_k] = _v
		end
	end
	local _exp_2 = Vivid.createElement("imagelabel", _attributes_3, Vivid.createElement("uiaspectratioconstraint"))
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.TextLabel
	end
	local _attributes_4 = {
		LayoutOrder = 2,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Visible = createEffect(function()
			if props.Text == "" or props.Text == nil then
				return false
			end
			return true
		end)(),
		Text = createEffect(function()
			local _result_4
			if props.variant == "link" then
				_result_4 = `<u>{props.Text}</u>`
			else
				local _condition_1 = (props.Text)
				if _condition_1 == nil then
					_condition_1 = ""
				end
				_result_4 = _condition_1
			end
			return _result_4
		end),
		RichText = createEffect(function()
			local _result_4
			if props.variant == "link" then
				_result_4 = true
			else
				local _condition_1 = (props.RichText)
				if _condition_1 == nil then
					_condition_1 = false
				end
				_result_4 = _condition_1
			end
			return _result_4
			-- return false;
		end)(),
		TextScaled = props.TextScaled,
		TextTruncate = props.TextTruncate,
		TextXAlignment = props.TextXAlignment,
		TextYAlignment = props.TextYAlignment,
		TextTransparency = props.TextTransparency,
		TextWrapped = props.TextWrapped,
		TextSize = function()
			local _condition_1 = (props.TextSize)
			if _condition_1 == nil then
				_condition_1 = Units().BaseTextSize
			end
			return _condition_1
		end,
		TextColor3 = function()
			return (props.TextColor3) or Theme().ButtonText
		end,
	}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_4[_k] = _v
		end
	end
	local _exp_3 = Vivid.createElement(Label, _attributes_4)
	local _result_4 = props.props
	if _result_4 ~= nil then
		_result_4 = _result_4.SpinnerContainer
	end
	local _attributes_5 = {
		LayoutOrder = 3,
		Visible = function()
			if props.loading == true then
				return true
			end
			return false
		end,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}
	if _result_4 then
		for _k, _v in _result_4 do
			_attributes_5[_k] = _v
		end
	end
	local _attributes_6 = {}
	local _condition_1 = (props.loading)
	if _condition_1 == nil then
		_condition_1 = false
	end
	_attributes_6.enabled = _condition_1
	_attributes_6.AnchorPoint = Vector2.new()
	_attributes_6.Position = UDim2.new()
	_attributes_6.Size = function()
		local _condition_2 = (props.TextSize)
		if _condition_2 == nil then
			_condition_2 = Units().BaseTextSize * 1.5
		end
		local _condition_3 = (props.TextSize)
		if _condition_3 == nil then
			_condition_3 = Units().BaseTextSize * 1.5
		end
		return UDim2.fromOffset(_condition_2, _condition_3)
	end
	local _result_5 = props.props
	if _result_5 ~= nil then
		_result_5 = _result_5.Spinner
	end
	if _result_5 then
		for _k, _v in _result_5 do
			_attributes_6[_k] = _v
		end
	end
	local _exp_4 = Vivid.createElement("frame", _attributes_5, Vivid.createElement(Spinner, _attributes_6))
	local _result_6 = props.props
	if _result_6 ~= nil then
		_result_6 = _result_6.UIStroke
	end
	local _attributes_7 = {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = function()
			return (props.strokeColor) or Theme().Border
		end,
		Thickness = props.strokeThickness,
		Transparency = function()
			return if props.variant == "ghost" then 1 else 0
		end,
	}
	if _result_6 then
		for _k, _v in _result_6 do
			_attributes_7[_k] = _v
		end
	end
	local _exp_5 = Vivid.createElement("uistroke", _attributes_7)
	local _result_7 = props.props
	if _result_7 ~= nil then
		_result_7 = _result_7.UICorner
	end
	local _attributes_8 = {
		CornerRadius = function()
			if props.roundness == nil then
				return UDim.new(0, 4)
			end
			local _roundness = props.roundness
			if type(_roundness) == "number" then
				return UDim.new(props.roundness, 0)
			end
			return props.roundness
		end,
	}
	if _result_7 then
		for _k, _v in _result_7 do
			_attributes_8[_k] = _v
		end
	end
	return Vivid.createElement("textbutton", _attributes, _exp, _exp_1, _exp_2, _exp_3, _exp_4, _exp_5, Vivid.createElement("uicorner", _attributes_8), props.children)
end
return {
	Button = Button,
}
