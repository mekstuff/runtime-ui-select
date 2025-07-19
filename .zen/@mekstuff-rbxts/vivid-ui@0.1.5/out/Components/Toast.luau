-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:41:45
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createState = _vivid.createState
local use = _vivid.use
local _Base = TS.import(script, script.Parent, "Base")
local Button = _Base.Button
local Label = _Base.Label
local _Utils = TS.import(script, script.Parent.Parent, "Utils")
local extp = _Utils.extp
local Theme = _Utils.Theme
local Units = _Utils.Units
-- import Icons from "Content/Icons";
-- import { DismissToast } from "Context/ToastsContext";
local function Toast(props)
	local IsHovering, setIsHovering = createState(false)
	local _exp = Vivid.createElement("uistroke", {
		Thickness = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = function()
			return if props.color == "info" then Theme().InfoText elseif props.color == "danger" then Theme().ErrorText elseif props.color == "warning" then Theme().WarningText else Theme().DropShadow
		end,
	})
	local _exp_1 = Vivid.createElement("uipadding", {
		PaddingLeft = UDim.new(0, 6),
		PaddingTop = UDim.new(0, 6),
		PaddingRight = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
	})
	local _exp_2 = Vivid.createElement("uicorner", {
		CornerRadius = props.roundness or UDim.new(0.2),
	})
	local _exp_3 = Vivid.createElement("uilistlayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 4),
	})
	local _exp_4 = Vivid.createElement("uilistlayout", {
		VerticalAlignment = Enum.VerticalAlignment.Center,
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	local _result = props.props
	if _result ~= nil then
		_result = _result.Icon
	end
	local _attributes = {
		LayoutOrder = 0,
		ImageColor3 = function()
			return if props.color == "info" then Theme().InfoText elseif props.color == "danger" then Theme().ErrorText elseif props.color == "warning" then Theme().WarningText else Theme().MainText
		end,
		BackgroundTransparency = 1,
		ImageTransparency = function()
			return if IsHovering() then 0 else 0.1
		end,
		Image = props.icon,
		Visible = function()
			return props.icon ~= nil and props.icon ~= ""
		end,
		Size = function()
			return UDim2.new(1, 0, 0, Units().BaseOffsetHeight * 0.75)
		end,
	}
	if _result then
		for _k, _v in _result do
			_attributes[_k] = _v
		end
	end
	local _exp_5 = Vivid.createElement("imagelabel", _attributes, Vivid.createElement("uiaspectratioconstraint", {
		DominantAxis = Enum.DominantAxis.Height,
	}))
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.Label
	end
	local _attributes_1 = {
		LayoutOrder = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = function()
			return if props.color == "info" then Theme().InfoText elseif props.color == "danger" then Theme().ErrorText elseif props.color == "warning" then Theme().WarningText else Theme().SubText
		end,
		TextTransparency = function()
			return if IsHovering() then 0 else 0.1
		end,
		TextWrapped = true,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = function()
			local XScale = 0.95
			if props.icon ~= nil and props.icon ~= "" then
				XScale -= 0.1
			end
			if props.buttonHidden ~= true then
				XScale -= 0.1
			end
			return UDim2.new(XScale, 0, 0, 0)
		end,
		Text = props.Text,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_1[_k] = _v
		end
	end
	local _exp_6 = Vivid.createElement(Label, _attributes_1)
	local _attributes_2 = {
		LayoutOrder = 3,
		BackgroundTransparency = 1,
		variant = "ghost",
		BackgroundColor3 = function()
			return if props.color == "info" then Theme().InfoText elseif props.color == "danger" then Theme().ErrorText elseif props.color == "warning" then Theme().WarningText else Theme().MainText
		end,
		icon = "rbxassetid://11422928451",
	}
	local _exp_7 = {
		IconImage = {
			ImageColor3 = function()
				return if props.color == "info" then Theme().InfoText elseif props.color == "danger" then Theme().ErrorText elseif props.color == "warning" then Theme().WarningText else Theme().MainText
			end,
		},
	}
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.Button
	end
	_attributes_2.props = extp(_exp_7, _result_2)
	_attributes_2.Visible = function()
		return not props.buttonHidden
	end
	_attributes_2.Size = function()
		return UDim2.new(1, 0, 0, Units().BaseOffsetHeight * 0.75)
	end
	_attributes_2.Activated = function()
		if props.buttonClicked ~= nil then
			props.buttonClicked(props.id)
		end
		local dismissToastListProvider = use(function()
			return props.dismissToastListProvider
		end)
		local dismissable = use(function()
			return props.dismissable
		end)
		if dismissable ~= true then
			return nil
		end
		assert(dismissToastListProvider, "dismissToastListProvider not provided for a dismissable Toast.")
		dismissToastListProvider.callback(props)
	end
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.Button
	end
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_2[_k] = _v
		end
	end
	return Vivid.createElement("textbutton", {
		MouseEnter = function()
			return setIsHovering(true)
		end,
		MouseLeave = function()
			return setIsHovering(false)
		end,
		AutoButtonColor = false,
		AnchorPoint = Vector2.new(0.5),
		Position = UDim2.fromScale(0.5),
		BackgroundColor3 = Theme().Dark,
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = "",
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 0),
		Activated = function()
			if props.toastClicked ~= nil then
				props.toastClicked(props.id)
			end
		end,
	}, _exp, _exp_1, _exp_2, _exp_3, Vivid.createElement("frame", {
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 1,
	}, _exp_4, _exp_5, _exp_6, Vivid.createElement(Button, _attributes_2, Vivid.createElement("uiaspectratioconstraint", {
		DominantAxis = Enum.DominantAxis.Height,
	}))), props.children)
end
return {
	Toast = Toast,
}
