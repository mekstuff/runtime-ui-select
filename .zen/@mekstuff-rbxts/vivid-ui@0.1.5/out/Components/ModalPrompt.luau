-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    08/05/2025 21:27:25
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local withProps = _vivid.withProps
local _Base = TS.import(script, script.Parent, "Base")
local Label = _Base.Label
local Modal = _Base.Modal
local function ModalPrompt(props)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.title = nil
	Properties.body = nil
	Properties.buttons = nil
	local _attributes = table.clone(withProps(props, true))
	setmetatable(_attributes, nil)
	local _result = props.props
	if _result ~= nil then
		_result = _result.ModalUIPadding
	end
	local _attributes_1 = {
		PaddingLeft = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 6),
		PaddingRight = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 6),
	}
	if _result then
		for _k, _v in _result do
			_attributes_1[_k] = _v
		end
	end
	local _exp = Vivid.createElement("uipadding", _attributes_1)
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.ModalUIListLayout
	end
	local _attributes_2 = {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Padding = UDim.new(0, 6),
		FillDirection = Enum.FillDirection.Vertical,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement("uilistlayout", _attributes_2)
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.TitleLabel
	end
	local _attributes_3 = {
		RichText = true,
		Text = createEffect(function()
			return `<b>{props.title}</b>`
		end)(),
	}
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_3[_k] = _v
		end
	end
	local _exp_2 = Vivid.createElement(Label, _attributes_3)
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.BodyLabel
	end
	local _attributes_4 = {
		TextWrapped = true,
		Text = props.body,
		Visible = createEffect(function()
			return props.body ~= ""
		end),
	}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_4[_k] = _v
		end
	end
	local _exp_3 = Vivid.createElement(Label, _attributes_4)
	local _result_4 = props.props
	if _result_4 ~= nil then
		_result_4 = _result_4.ButtonsFrame
	end
	local _attributes_5 = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1),
		AutomaticSize = Enum.AutomaticSize.Y,
	}
	if _result_4 then
		for _k, _v in _result_4 do
			_attributes_5[_k] = _v
		end
	end
	local _result_5 = props.props
	if _result_5 ~= nil then
		_result_5 = _result_5.ButtonsUIListLayout
	end
	local _attributes_6 = {
		Padding = UDim.new(0, 4),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
	}
	if _result_5 then
		for _k, _v in _result_5 do
			_attributes_6[_k] = _v
		end
	end
	return Vivid.createElement(Modal, _attributes, _exp, _exp_1, _exp_2, _exp_3, Vivid.createElement("frame", _attributes_5, Vivid.createElement("uilistlayout", _attributes_6), props.buttons))
end
return {
	ModalPrompt = ModalPrompt,
}
