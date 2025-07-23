-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 23:47:47
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createState = _vivid.createState
local use = _vivid.use
local WithTransition = _vivid.WithTransition
local Tags = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Tags").Tags
local RoundTo2DecimalPlaces = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "Format").RoundTo2DecimalPlaces
local DimensionBoxTextInfo = TS.import(script, script.Parent, "DimensionBoxTextInfo").DimensionBoxTextInfo
local DimensionBoxTextInfoList = TS.import(script, script.Parent, "DimensionBoxTextInfoList").DimensionBoxTextInfoList
local Theme = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out).Theme
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local function DimensionBox(props)
	local AdorneeStatic = use(function()
		return props.Adornee
	end)
	local AdorneeAbsoluteSize, setAdorneeAbsoluteSize = createState(use(function()
		return AdorneeStatic.AbsoluteSize
	end))
	local AdorneeAbsolutePosition, setAdorneeAbsolutePosition = createState(use(function()
		return AdorneeStatic.AbsolutePosition
	end))
	createEffect(function()
		local AbsolutePositionChangedListener = props.Adornee:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
			if props.Adornee == nil then
				return nil
			end
			setAdorneeAbsolutePosition(props.Adornee.AbsolutePosition)
		end)
		createCleanup(function()
			AbsolutePositionChangedListener:Disconnect()
		end)
	end)
	createEffect(function()
		local AbsoluteSizeChangedListener = props.Adornee:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if props.Adornee == nil then
				return nil
			end
			setAdorneeAbsoluteSize(props.Adornee.AbsoluteSize)
		end)
		createCleanup(function()
			AbsoluteSizeChangedListener:Disconnect()
		end)
	end)
	return Vivid.createElement("frame", {
		tags = { Tags.IgnoreHoverDetection },
		BackgroundTransparency = 1,
		Size = createEffect(function()
			return UDim2.fromOffset(AdorneeAbsoluteSize().X, AdorneeAbsoluteSize().Y)
		end),
		Position = createEffect(function()
			return UDim2.fromOffset(AdorneeAbsolutePosition().X, AdorneeAbsolutePosition().Y)
		end),
	}, Vivid.createElement("uistroke", {
		Thickness = 2,
		Transparency = createEffect(function()
			return WithTransition(0, {
				DefaultValue = 1,
			})
		end),
		Color = props.PrimaryColor,
	}), Vivid.createElement(DimensionBoxTextInfoList, {
		ViewportSize = props.ViewportSize,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, 0, 0, -6),
		PrimaryColor = props.PrimaryColor,
		BackgroundColor = props.BackgroundColor,
		children = { Vivid.createElement(DimensionBoxTextInfo, {
			truthy = createEffect(function()
				return props.ShowAbsoluteSize
			end)(),
			Text = createEffect(function()
				return `{RoundTo2DecimalPlaces(AdorneeAbsoluteSize().X)}w X {RoundTo2DecimalPlaces(AdorneeAbsoluteSize().Y)}h`
			end),
		}) },
	}), Vivid.createElement("textbutton", {
		tags = { Tags.IgnoreHoverDetection },
		Active = true,
		Interactable = true,
		Text = "",
		Visible = SettingsContext.BlockButtonActivations.get(),
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	}), Vivid.createElement(DimensionBoxTextInfoList, {
		ViewportSize = props.ViewportSize,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 1, 6),
		PrimaryColor = props.PrimaryColor,
		BackgroundColor = props.BackgroundColor,
		children = { Vivid.createElement(DimensionBoxTextInfo, {
			truthy = createEffect(function()
				return props.ShowAbsolutePosition
			end)(),
			Text = createEffect(function()
				return `{RoundTo2DecimalPlaces(AdorneeAbsolutePosition().X)} x {RoundTo2DecimalPlaces(AdorneeAbsolutePosition().Y)}`
			end),
		}), Vivid.createElement(DimensionBoxTextInfo, {
			truthy = createEffect(function()
				return props.ShowInstanceName
			end)(),
			Text = createEffect(function()
				if props.Adornee == nil then
					return ""
				end
				return `{props.Adornee.Name}`
			end)(),
			TextColor3 = Theme().MainButton,
		}) },
	}))
end
return {
	DimensionBox = DimensionBox,
}
