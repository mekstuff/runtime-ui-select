-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:38:16
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createSpring = _vivid.createSpring
local ZIndexLayer = _vivid.ZIndexLayer
local Theme = TS.import(script, script.Parent.Parent.Parent, "Utils").Theme
local function Drawer(props)
	local DrawerPosition, setDrawerPosition = createSpring(UDim2.new(0.5, 0, 2, 0), 0.75, 1.6)
	local DrawerAnchorPoint, setDrawerAnchorPoint = createSpring(Vector2.new(0.5, 1))
	local DrawerBackdropTransparency, setDrawerBackdropTransparency = createSpring(1, 1, 1.6)
	createEffect(function()
		setDrawerBackdropTransparency(if props.opened == true then 0.5 else 1)
		local StartPositionX = if props.horizontalAlignment == Enum.HorizontalAlignment.Left then -2 elseif props.horizontalAlignment == Enum.HorizontalAlignment.Right then 2 else 0.5
		local StartPositionY = if props.verticalAlignment == Enum.VerticalAlignment.Top then -2 elseif props.verticalAlignment == Enum.VerticalAlignment.Center then 0.5 else 2
		local EndPositionY = if props.verticalAlignment == Enum.VerticalAlignment.Top then 0 elseif props.verticalAlignment == Enum.VerticalAlignment.Center then 0.5 else 1
		setDrawerAnchorPoint(function()
			return if props.verticalAlignment == Enum.VerticalAlignment.Top then Vector2.new(0.5, 0) elseif props.verticalAlignment == Enum.VerticalAlignment.Center then Vector2.new(0.5, 0.5) else Vector2.new(0.5, 1)
		end)
		setDrawerPosition(if props.opened == true then UDim2.new(0.5, 0, EndPositionY, if props.verticalAlignment == Enum.VerticalAlignment.Top then -20 elseif props.verticalAlignment == Enum.VerticalAlignment.Center then 0 else 20) else UDim2.new(StartPositionX, 0, StartPositionY, 0))
	end)
	local _result = props.props
	if _result ~= nil then
		_result = _result.Backdrop
	end
	local _attributes = {
		Activated = props.onDismiss,
		Visible = function()
			return DrawerBackdropTransparency() ~= 1
		end,
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = DrawerBackdropTransparency(),
		Text = "",
		ZIndex = 2,
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
		ZIndex = 3,
		AnchorPoint = DrawerAnchorPoint(),
		Position = DrawerPosition(),
		Size = function()
			local _condition = props.scale
			if _condition == nil then
				_condition = 0.75
			end
			return UDim2.new(1, 0, _condition, 0)
		end,
		BackgroundColor3 = Theme().MainBackground,
		Text = "",
		AutoButtonColor = false,
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
		CornerRadius = UDim.new(0, 10),
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
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(255),
		ZIndex = 3,
		Position = UDim2.new(0.5, 0, 0, 10),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(1, -20, 1, -30),
	}
	if _result_3 then
		for _k, _v in _result_3 do
			_attributes_3[_k] = _v
		end
	end
	return Vivid.createElement("textbutton", _attributes, Vivid.createElement("textbutton", _attributes_1, _exp, Vivid.createElement(ZIndexLayer, _attributes_3, props.children)))
end
return {
	Drawer = Drawer,
}
