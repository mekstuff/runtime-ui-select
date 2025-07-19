-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:41:35
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createSpring = _vivid.createSpring
local use = _vivid.use
local withProps = _vivid.withProps
local _Utils = TS.import(script, script.Parent.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local function ToggleSwitch(props)
	local ToggledSpring, setToggledSpring = createSpring(0, 0.6, 2.5)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.toggled = nil
	Properties.disabled = nil
	Properties.onToggle = nil
	Properties.setToggled = nil
	createEffect(function()
		if props.disabled == true then
			local setToggled = use(function()
				return props.setToggled
			end)
			if setToggled == nil then
				return nil
			end
			setToggled(false)
		end
	end)
	createEffect(function()
		setToggledSpring(if props.toggled == true then 1 else 0)
	end)
	local _attributes = {
		Size = function()
			return UDim2.fromOffset(Units().BaseOffsetWidth * 0.8, Units().BaseOffsetHeight * 0.6)
		end,
		Text = "",
		BackgroundColor3 = function()
			return if props.disabled == true then Theme().Dark elseif props.toggled == true then Theme().MainButton else Theme().DimmedText
		end,
		AutoButtonColor = false,
		Active = function()
			return not props.disabled
		end,
		Activated = if props.onToggle then props.onToggle else function()
			local setToggled = use(function()
				return props.setToggled
			end)
			if setToggled == nil then
				return nil
			end
			setToggled(function(old)
				return not old
			end)
		end,
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	local _result = props.props
	if _result ~= nil then
		_result = _result.UICorner
	end
	local _attributes_1 = {
		CornerRadius = UDim.new(1, 0),
	}
	if _result then
		for _k, _v in _result do
			_attributes_1[_k] = _v
		end
	end
	local _exp = Vivid.createElement("uicorner", _attributes_1)
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.UIPadding
	end
	local _attributes_2 = {
		PaddingLeft = UDim.new(0, 2),
		PaddingTop = UDim.new(0, 1),
		PaddingRight = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 1),
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement("uipadding", _attributes_2)
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.ToggleFrame
	end
	local _attributes_3 = {
		AnchorPoint = function()
			return Vector2.new(ToggledSpring(), 0)
		end,
		Position = function()
			return UDim2.fromScale(ToggledSpring(), 0)
		end,
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = Theme().MainBackground,
	}
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_3[_k] = _v
		end
	end
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.ToggleFrameUIAspectRatioConstraint
	end
	local _attributes_4 = {
		DominantAxis = Enum.DominantAxis.Height,
		AspectType = Enum.AspectType.ScaleWithParentSize,
	}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_4[_k] = _v
		end
	end
	local _exp_2 = Vivid.createElement("uiaspectratioconstraint", _attributes_4)
	local _result_4 = props.props
	if _result_4 ~= nil then
		_result_4 = _result_4.ToggleFrameUICorner
	end
	local _attributes_5 = {
		CornerRadius = UDim.new(1),
	}
	if _result_4 then
		for _k, _v in _result_4 do
			_attributes_5[_k] = _v
		end
	end
	return Vivid.createElement("textbutton", _attributes, _exp, _exp_1, Vivid.createElement("frame", _attributes_3, _exp_2, Vivid.createElement("uicorner", _attributes_5)))
end
return {
	ToggleSwitch = ToggleSwitch,
}
