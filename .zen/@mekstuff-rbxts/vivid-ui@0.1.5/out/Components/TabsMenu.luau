-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:39:59
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createSpring = _vivid.createSpring
local createState = _vivid.createState
local For = _vivid.For
local Show = _vivid.Show
local use = _vivid.use
local withProps = _vivid.withProps
local _Utils = TS.import(script, script.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local Label = TS.import(script, script.Parent, "Base").Label
local function TabMenuButton(props)
	local Properties = withProps(props, true)
	Properties.icon = nil
	Properties.onClick = nil
	Properties.isSelected = nil
	local HoveringSpring, setHoveringSpring = createSpring(0, 1, 3)
	local _attributes = {
		Activated = props.onClick,
		BorderSizePixel = 0,
		BackgroundTransparency = function()
			return if props.isSelected then 0.6 else math.clamp(math.abs(1 - HoveringSpring()), 0.8, 1)
		end,
		BackgroundColor3 = Theme().MainButton,
		AutoButtonColor = false,
		MouseEnter = function()
			return setHoveringSpring(1)
		end,
		MouseLeave = function()
			return setHoveringSpring(0)
		end,
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	_attributes.Text = ""
	return Vivid.createElement("textbutton", _attributes, Vivid.createElement("uilistlayout", {
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 4),
	}), Vivid.createElement("imagelabel", {
		ImageColor3 = Theme().SubText,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20, 20),
		Image = props.icon,
		Visible = function()
			return props.icon ~= nil
		end,
	}), Vivid.createElement(Label, {
		TextSize = Units().BaseTextSize,
		TextColor3 = Theme().SubText,
		BackgroundTransparency = 1,
		Text = props.Text,
		Visible = function()
			return props.Text ~= ""
		end,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))
end
local function TabsMenu(props)
	local ActiveTabIndex, setActiveTabIndex = createState(0)
	local ActiveTabHighligherPosition, setActiveTabHighligherPosition = createSpring(UDim2.new(), 0.7, 2)
	createEffect(function()
		setActiveTabHighligherPosition(UDim2.fromScale(ActiveTabIndex() / #props.tabs))
	end)
	return Vivid.createElement("frame", {
		BackgroundColor3 = Theme().MainBackground,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
	}, Vivid.createElement("uilistlayout", {
		FillDirection = Enum.FillDirection.Vertical,
		VerticalFlex = Enum.UIFlexAlignment.Fill,
	}), Vivid.createElement("frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = Theme().ScriptBackground,
		Size = function()
			return UDim2.new(1, 0, 0, Units().BaseOffsetHeight * 2)
		end,
	}, Vivid.createElement("uigridlayout", {
		CellPadding = UDim2.new(),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		CellSize = function()
			return UDim2.new(1 / #props.tabs, 0, 1, 0)
		end,
	}), Vivid.createElement(For, {
		each = props.tabs,
		children = function(tabProps, index)
			return Vivid.createElement(TabMenuButton, {
				isSelected = createEffect(function()
					return index() - 1 == ActiveTabIndex()
				end)(),
				BackgroundColor3 = props.highlighterColor3,
				onClick = function()
					setActiveTabIndex(use(function()
						return index()
					end) - 1)
				end,
				icon = tabProps.icon,
				Text = tabProps.title,
			})
		end,
	})), Vivid.createElement("frame", {
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundTransparency = 1,
	}, Vivid.createElement("frame", {
		BorderSizePixel = 0,
		Position = ActiveTabHighligherPosition(),
		BackgroundColor3 = function()
			return props.highlighterColor3 or Theme().MainButton
		end,
		Size = function()
			return UDim2.new(1 / #props.tabs, 0, 1, 0)
		end,
	})), Vivid.createElement("frame", {
		BackgroundColor3 = Theme().MainBackground,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
	}, Vivid.createElement(For, {
		each = props.tabs,
		children = function(props, index)
			return Vivid.createElement(Show, {
				when = createEffect(function()
					return index() - 1 == ActiveTabIndex()
				end),
				children = props.content,
			})
		end,
	})))
end
return {
	TabsMenu = TabsMenu,
}
