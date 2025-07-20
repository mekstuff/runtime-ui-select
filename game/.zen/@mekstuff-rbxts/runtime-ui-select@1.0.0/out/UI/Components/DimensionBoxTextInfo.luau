-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    13/07/2025 20:21:28
	
]]
local TextService = game:GetService("TextService")
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Case = _vivid.Case
local createEffect = _vivid.createEffect
local createRef = _vivid.createRef
local createState = _vivid.createState
local Switch = _vivid.Switch
local withProps = _vivid.withProps
local WithTransition = _vivid.WithTransition
local _vivid_ui = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out)
local Button = _vivid_ui.Button
local Theme = _vivid_ui.Theme
local Units = _vivid_ui.Units
local Tags = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Tags").Tags
local function DimensionBoxTextInfo(props)
	local Properties = withProps(props, true)
	Properties.truthy = nil
	local ButtonRef = createRef()
	local TextBounds, setTextBounds = createState(Vector2.new(0, 0))
	createEffect(function()
		local BtnRef = ButtonRef()
		if BtnRef == nil then
			return nil
		end
		local TextBoundsParams = Instance.new("GetTextBoundsParams")
		local _condition = props.TextSize
		if _condition == nil then
			_condition = BtnRef.TextSize
		end
		TextBoundsParams.Size = _condition
		TextBoundsParams.Font = (props.FontFace or BtnRef.FontFace)
		local _condition_1 = props.RichText
		if _condition_1 == nil then
			_condition_1 = BtnRef.RichText
		end
		TextBoundsParams.RichText = _condition_1
		local _condition_2 = props.Text
		if _condition_2 == nil then
			_condition_2 = BtnRef.Text
		end
		TextBoundsParams.Text = _condition_2
		TextBoundsParams.Width = 10e10
		task.spawn(function()
			setTextBounds(TextService:GetTextBoundsAsync(TextBoundsParams))
		end)
	end)
	return Vivid.createElement(Switch, {
		conditional = createEffect(function()
			return props.truthy == true
		end)(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		local _attributes = {
			tags = { Tags.IgnoreHoverDetection },
			variant = "ghost",
			padding = 0,
			props = {
				IconImage = {
					tags = { Tags.IgnoreHoverDetection },
				},
				SpinnerContainer = {
					tags = { Tags.IgnoreHoverDetection },
				},
				TextLabel = {
					tags = { Tags.IgnoreHoverDetection },
				},
			},
			BackgroundTransparency = 1,
			TextColor3 = Theme().SubText,
			TextSize = createEffect(function()
				return Units().BaseTextSize - 1
			end)(),
			TextTruncate = Enum.TextTruncate.None,
			AutomaticSize = Enum.AutomaticSize.None,
			Size = createEffect(function()
				return UDim2.fromOffset(TextBounds().X, TextBounds().Y)
			end)(),
			TextTransparency = createEffect(function()
				return WithTransition(0, {
					DefaultValue = 1,
				})
			end),
			forwardRef = props.ref,
		}
		for _k, _v in Properties do
			_attributes[_k] = _v
		end
		_attributes.ref = ButtonRef
		return Vivid.createElement(Button, _attributes)
	end), Vivid.createElement(Case, {
		condition = false,
	}, function()
		return Vivid.createElement(Vivid.createFragment)
	end))
end
return {
	DimensionBoxTextInfo = DimensionBoxTextInfo,
}
