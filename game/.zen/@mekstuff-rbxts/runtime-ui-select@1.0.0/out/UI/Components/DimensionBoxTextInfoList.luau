-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    13/07/2025 20:20:58
	
]]
local GuiService = game:GetService("GuiService")
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Box = _vivid.Box
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createRef = _vivid.createRef
local createState = _vivid.createState
local WithTransition = _vivid.WithTransition
local Tags = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Tags").Tags
local function DimensionBoxTextInfoList(props)
	local PositionXOffset, setPositionXOffset = createState(0)
	local PositionYOffset, setPositionYOffset = createState(0)
	local BoxRef = createRef()
	createEffect(function()
		local Ref = BoxRef()
		if Ref == nil then
			return nil
		end
		local UpdateBoundings = function()
			local GuiInset = GuiService.TopbarInset
			-- X Axis
			if Ref.AbsolutePosition.X < 0 then
				setPositionXOffset(math.abs(Ref.AbsolutePosition.X))
			elseif Ref.AbsolutePosition.X + Ref.AbsoluteSize.X > props.ViewportSize.X then
				setPositionXOffset(-math.abs(Ref.AbsolutePosition.X + Ref.AbsoluteSize.X - props.ViewportSize.X))
			else
				setPositionXOffset(0)
			end
			-- Y Axis
			local AbsolutePositionY = Ref.AbsolutePosition.Y + GuiInset.Height
			if AbsolutePositionY < 0 then
				setPositionYOffset(math.abs(AbsolutePositionY))
			elseif AbsolutePositionY + Ref.AbsoluteSize.Y > props.ViewportSize.Y then
				setPositionYOffset(-math.abs(AbsolutePositionY + Ref.AbsoluteSize.Y - props.ViewportSize.Y))
			else
				setPositionYOffset(0)
			end
		end
		local AbsoluteSizeListener = Ref:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateBoundings)
		UpdateBoundings()
		createCleanup(function()
			AbsoluteSizeListener:Disconnect()
		end)
	end)
	local _exp = Vivid.createElement("uicorner", {
		CornerRadius = UDim.new(0, 1),
	})
	local _exp_1 = Vivid.createElement("uistroke", {
		Transparency = 0.05,
		Color = props.PrimaryColor,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
	local _result = props.children
	if _result ~= nil then
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_result)
		local _callback = function(child)
			return child
		end
		for _k, _v in _result do
			_newValue[_k] = _callback(_v, _k - 1, _result)
		end
		-- ▲ ReadonlyArray.map ▲
		_result = _newValue
	end
	return Vivid.createElement("frame", {
		ref = BoxRef,
		tags = { Tags.IgnoreHoverDetection },
		AnchorPoint = props.AnchorPoint,
		Position = createEffect(function()
			local _position = props.Position
			local _arg0 = UDim2.fromOffset(PositionXOffset(), PositionYOffset())
			return _position + _arg0
		end),
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
	}, Vivid.createElement(Box, {
		tags = { Tags.IgnoreHoverDetection },
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		UIPadding = 2,
		Padding = UDim.new(0, 4),
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = props.BackgroundColor,
		BackgroundTransparency = createEffect(function()
			return WithTransition(0.05, {
				DefaultValue = 1,
			})
		end),
		BorderSizePixel = 0,
	}, _exp, _exp_1, _result))
end
return {
	DimensionBoxTextInfoList = DimensionBoxTextInfoList,
}
