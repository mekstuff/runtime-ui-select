-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
		Typed with ❤️ @mekstuff
		07/05/2025 18:41:57
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local withProps = _vivid.withProps
local Theme = TS.import(script, script.Parent.Parent.Parent, "Utils").Theme
local function Input(props)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.children = nil
	Properties.strokeThickness = nil
	Properties.roundness = nil
	Properties.padding = nil
	Properties.color = nil
	local _attributes = {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Text = "",
		ClearTextOnFocus = false,
		ClipsDescendants = true,
		PlaceholderText = "Input",
		TextColor3 = Theme().MainText,
		PlaceholderColor3 = Theme().DimmedText,
		TextXAlignment = Enum.TextXAlignment.Left,
	}
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
		_result_1 = _result_1.UIStroke
	end
	local _attributes_2 = {
		Name = "DSODS",
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = function()
			if props.color == "primary" then
				return Theme().MainButton
			end
			if props.color == "border" then
				return Theme().DimmedText
			end
			return Theme().InputFieldBorder
		end,
		Thickness = props.strokeThickness,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement("uistroke", _attributes_2)
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.UICorner
	end
	local _attributes_3 = {
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
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_3[_k] = _v
		end
	end
	return Vivid.createElement("textbox", _attributes, _exp, _exp_1, Vivid.createElement("uicorner", _attributes_3), props.children)
end
return {
	Input = Input,
}
