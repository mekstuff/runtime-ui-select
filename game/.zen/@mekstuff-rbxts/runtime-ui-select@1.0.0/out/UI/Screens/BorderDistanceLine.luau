-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    18/07/2025 18:15:08
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createState = _vivid.createState
local Tags = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Tags").Tags
local RoundTo2DecimalPlaces = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "Format").RoundTo2DecimalPlaces
local function BorderDistanceLine(props)
	local LineBorderThickness = 0.45
	local Size, setSize = createState(UDim2.new())
	local Position, setPosition = createState(UDim2.new())
	local AnchorPoint, setAnchorPoint = createState(Vector2.zero)
	local UpdatePositioning = function()
		if props.Position == "Left" then
			setAnchorPoint(Vector2.new(1, 0.5))
			setPosition(UDim2.fromScale(0, 0.5))
			return nil
		end
		if props.Position == "Top" then
			setAnchorPoint(Vector2.new(0.5, 1))
			setPosition(UDim2.fromScale(0.5, 0))
			return nil
		end
		if props.Position == "Right" then
			setAnchorPoint(Vector2.new(0, 0.5))
			setPosition(UDim2.fromScale(1, 0.5))
			return nil
		end
		if props.Position == "Bottom" then
			setAnchorPoint(Vector2.new(0.5, 0))
			setPosition(UDim2.fromScale(0.5, 1))
			return nil
		end
	end
	local UpdateSizing = function()
		if props.Position == "Left" or props.Position == "Right" then
			setSize(UDim2.fromOffset(props.Length, props.Thickness))
			return nil
		end
		if props.Position == "Top" or props.Position == "Bottom" then
			setSize(UDim2.fromOffset(props.Thickness, props.Length))
			return nil
		end
	end
	createEffect(function()
		local _ = props.Position
		UpdatePositioning()
	end)
	createEffect(function()
		local _ = props.Position
		local _1 = props.Length
		UpdateSizing()
	end)
	return Vivid.createElement("frame", {
		tags = { Tags.IgnoreHoverDetection },
		Size = Size(),
		Position = Position(),
		AnchorPoint = AnchorPoint(),
		BackgroundTransparency = 0,
		BackgroundColor3 = props.PrimaryColor,
		BorderSizePixel = 0,
	}, Vivid.createElement("uistroke", {
		Color = props.BorderColor,
		Thickness = LineBorderThickness,
	}), Vivid.createElement("textlabel", {
		tags = { Tags.IgnoreHoverDetection },
		AutomaticSize = Enum.AutomaticSize.XY,
		Text = createEffect(function()
			return `{RoundTo2DecimalPlaces(props.Length)}`
		end)(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		TextColor3 = props.TextColor,
		BackgroundColor3 = props.PrimaryColor,
		BorderSizePixel = 0,
	}, Vivid.createElement("uipadding", {
		PaddingLeft = UDim.new(0, 2),
		PaddingTop = UDim.new(0, 2),
		PaddingRight = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 2),
	}), Vivid.createElement("uicorner", {
		CornerRadius = UDim.new(0.3, 0),
	}), Vivid.createElement("uistroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = props.BorderColor,
		Thickness = LineBorderThickness,
	})))
end
return {
	BorderDistanceLine = BorderDistanceLine,
}
