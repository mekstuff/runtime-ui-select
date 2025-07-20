-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:45:08
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createRef = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out.create.createRef).createRef
local _Utils = TS.import(script, script.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local Label = TS.import(script, script.Parent, "Base").Label
local TextService = game:GetService("TextService")
local function SettingContentSeperatorLine(props)
	local _attributes = {
		BorderSizePixel = 0,
		BackgroundTransparency = 0.1,
		BackgroundColor3 = Theme().Border,
		Size = UDim2.new(1, 0, 0, 1),
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement("frame", _attributes)
end
local function SettingContentSeperator(props)
	local LabelRef = createRef()
	return Vivid.createElement("frame", {
		Visible = props.Visible,
		LayoutOrder = props.LayoutOrder,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(1, -10, 0, 0),
	}, Vivid.createElement("uilistlayout", {
		Padding = UDim.new(0, 10),
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
	}), Vivid.createElement(Label, {
		ref = LabelRef,
		onMount = function()
			local Ref = LabelRef()
			-- Automatic sizing cause weird sizing bug, fix with custom autosize:
			local UpdateSize = function()
				local TextBoundsParams = Instance.new("GetTextBoundsParams")
				TextBoundsParams.Text = Ref.Text
				TextBoundsParams.Font = Ref.FontFace
				TextBoundsParams.Size = Ref.TextSize
				TextBoundsParams.Width = (Ref.Parent).AbsoluteSize.X * 0.5
				local TextBounds = TextService:GetTextBoundsAsync(TextBoundsParams)
				Ref.Size = UDim2.fromOffset(TextBounds.X, TextBounds.Y)
			end
			Ref:GetPropertyChangedSignal("Text"):Connect(function()
				UpdateSize()
			end)
			task.defer(function()
				-- TODO: Fix with onMount - Ref isn't parented yet, so we added this defer as a hot fix.
				UpdateSize()
			end)
		end,
		TextSize = function()
			return Units().BaseTextSize
		end,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		TextColor3 = Theme().DimmedText,
		Text = props.seperatorText,
	}), Vivid.createElement(SettingContentSeperatorLine))
end
local function SettingContent(props)
	return Vivid.createElement("frame", {
		Visible = props.Visible,
		LayoutOrder = props.LayoutOrder,
		BackgroundTransparency = 1,
		Size = function()
			return UDim2.new(1, 0, 0, Units().BaseOffsetHeight * 1.2)
		end,
	}, Vivid.createElement(SettingContentSeperatorLine, {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Visible = function()
			return if props.hideSplitter then false else true
		end,
	}), Vivid.createElement("frame", {
		Name = "Content",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5),
		Size = UDim2.new(1, -10, 1, -1),
	}, Vivid.createElement("uipadding", {
		PaddingLeft = UDim.new(0, 8),
		PaddingTop = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
	}), Vivid.createElement("uilistlayout", {
		Padding = UDim.new(0, 10),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalFlex = Enum.UIFlexAlignment.Fill,
	}), Vivid.createElement(Label, {
		TextSize = function()
			return Units().BaseTextSize
		end,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Theme().SubText,
		Size = createEffect(function()
			local _condition = (props.scaleDistribution)
			if _condition == nil then
				_condition = 0.5
			end
			return UDim2.new(_condition, -5, 1, 0)
		end)(),
		Text = props.titleText,
		BackgroundTransparency = 1,
	}), Vivid.createElement("frame", {
		BackgroundTransparency = 1,
		Size = createEffect(function()
			local _condition = (props.scaleDistribution)
			if _condition == nil then
				_condition = 0.5
			end
			return UDim2.new(1 - _condition, -5, 1, 0)
		end)(),
	}, Vivid.createElement("uilistlayout", {
		Padding = UDim.new(0, 5),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center,
	}), props.children)))
end
return {
	SettingContentSeperator = SettingContentSeperator,
	SettingContent = SettingContent,
}
