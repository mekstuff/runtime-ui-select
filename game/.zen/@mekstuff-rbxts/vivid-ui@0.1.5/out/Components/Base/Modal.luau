-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 10:17:39
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createSpring = _vivid.createSpring
local use = _vivid.use
local ZIndexLayer = _vivid.ZIndexLayer
local Theme = TS.import(script, script.Parent.Parent.Parent, "Utils").Theme
local ModalZIndexLayerDefaultZIndex = 3
local function Modal(props)
	local ModalPosition, setModalPosition = createSpring(use(function()
		return props.closedPosition
	end) or UDim2.new(0.5, 0, 2, 0), 0.75, 1.6)
	local ModalBackdropTransparency, setModalBackdropTransparency = createSpring(1, 1, 1.6)
	local GroupTransparency, setGroupTransparency = createSpring(1, 1, 1.6)
	createEffect(function()
		setModalPosition(if props.opened == true then (props.openedPosition or UDim2.new(0.5, 0, 0.5, 20)) else (props.closedPosition or UDim2.new(0.5, 0, 2, 0)))
		local _result
		if props.opened == true then
			local _condition = props.backdropTransparency
			if _condition == nil then
				_condition = 0.5
			end
			_result = _condition
		else
			_result = 1
		end
		setModalBackdropTransparency(_result)
		setGroupTransparency(if props.opened == true then 0 else 1)
	end)
	local _result = props.props
	if _result ~= nil then
		_result = _result.Backdrop
	end
	local _attributes = {
		Activated = props.onDismiss,
		Visible = function()
			if props.opened == false and ModalBackdropTransparency() == 1 then
				return false
			end
			return true
		end,
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = ModalBackdropTransparency(),
		Text = "",
		ZIndex = ModalZIndexLayerDefaultZIndex - 1,
		Size = UDim2.new(1, 0, 1, 0),
	}
	if _result then
		for _k, _v in _result do
			_attributes[_k] = _v
		end
	end
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.Container
	end
	local _attributes_1 = {
		ZIndex = ModalZIndexLayerDefaultZIndex,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = ModalPosition(),
		GroupTransparency = GroupTransparency(),
		Size = function()
			local _condition = props.scale
			if _condition == nil then
				_condition = 0.7
			end
			return UDim2.new(_condition, 0, 0, 0)
		end,
		BackgroundColor3 = Theme().MainBackground,
		AutomaticSize = Enum.AutomaticSize.Y,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_1[_k] = _v
		end
	end
	local _result_2 = props.props
	if _result_2 ~= nil then
		_result_2 = _result_2.UICorner
	end
	local _attributes_2 = {
		CornerRadius = UDim.new(0, 4),
	}
	if _result_2 then
		for _k, _v in _result_2 do
			_attributes_2[_k] = _v
		end
	end
	local _exp = Vivid.createElement("uicorner", _attributes_2)
	local _result_3 = props.props
	if _result_3 ~= nil then
		_result_3 = _result_3.ZIndexLayer
	end
	local _attributes_3 = {
		Size = UDim2.fromScale(1),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		ZIndex = ModalZIndexLayerDefaultZIndex,
		Position = UDim2.new(0.5, 0, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0),
	}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_3[_k] = _v
		end
	end
	return Vivid.createElement("textbutton", _attributes, Vivid.createElement("canvasgroup", _attributes_1, _exp, Vivid.createElement(ZIndexLayer, _attributes_3, props.children)))
end
return {
	Modal = Modal,
	ModalZIndexLayerDefaultZIndex = ModalZIndexLayerDefaultZIndex,
}
