-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:37:02
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local withProps = _vivid.withProps
local _Utils = TS.import(script, script.Parent.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local function Checkbox(props)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.icon = nil
	Properties.toggled = nil
	Properties.disabled = nil
	local _attributes = {
		BackgroundColor3 = function()
			if props.disabled == true then
				return Theme().DimmedText
			end
			return Theme().MainButton
		end,
		BackgroundTransparency = function()
			return if props.toggled then 0 else 1
		end,
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		Size = function()
			return UDim2.fromOffset(Units().BaseOffsetHeight * 0.5, Units().BaseOffsetHeight * 0.5)
		end,
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	local _result = props.props
	if _result ~= nil then
		_result = _result.ImageLabel
	end
	local _attributes_1 = {
		Visible = props.toggled,
		Image = function()
			local _condition = props.icon
			if _condition == nil then
				_condition = "http://www.roblox.com/asset/?id=6031094667"
			end
			return _condition
		end,
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(0.95, 0, 0.95, 0),
	}
	if _result then
		for _k, _v in _result do
			_attributes_1[_k] = _v
		end
	end
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.UIAspectRatioConstraint
	end
	local _attributes_2 = {
		DominantAxis = Enum.DominantAxis.Height,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	local _exp = Vivid.createElement("imagelabel", _attributes_1, Vivid.createElement("uiaspectratioconstraint", _attributes_2))
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.UICorner
	end
	local _attributes_3 = {
		CornerRadius = UDim.new(0.2),
	}
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_3[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement("uicorner", _attributes_3)
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.UIStroke
	end
	local _attributes_4 = {
		Color = function()
			if props.disabled == true then
				return Theme().DimmedText
			end
			return Theme().MainButton
		end,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Thickness = 2,
	}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_4[_k] = _v
		end
	end
	return Vivid.createElement("textbutton", _attributes, _exp, _exp_1, Vivid.createElement("uistroke", _attributes_4))
end
return {
	Checkbox = Checkbox,
}
