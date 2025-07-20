-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    06/06/2025 19:12:41
	
]]
--[[
	
	    Typed with ❤️ @mekstuff
	    06/06/2025 18:30:19
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Box = _vivid.Box
local createEffect = _vivid.createEffect
local withProps = _vivid.withProps
local Button = TS.import(script, script.Parent, "Base").Button
local Icons = TS.import(script, script.Parent.Parent, "Icons").Icons
local extp = TS.import(script, script.Parent.Parent, "Utils").extp
local function Accordion(props)
	local Properties = withProps(props, true)
	-- delete Properties.props?.AccordionBox;
	-- delete Properties.props?.AccordionChildrenContainer;
	Properties.children = nil
	Properties.expanded = nil
	Properties.expandedIcon = nil
	Properties.collapsedIcon = nil
	local _result = props.props
	if _result ~= nil then
		_result = _result.AccordionBox
	end
	local _attributes = {
		AutomaticSize = Enum.AutomaticSize.XY,
		FillDirection = Enum.FillDirection.Vertical,
		BackgroundTransparency = 1,
		Size = props.Size,
		SortOrder = Enum.SortOrder.LayoutOrder,
	}
	if _result then
		for _k, _v in _result do
			_attributes[_k] = _v
		end
	end
	local _attributes_1 = {
		icon = createEffect(function()
			local _result_1
			if props.expanded == true then
				local _condition = (props.expandedIcon)
				if _condition == nil then
					_condition = Icons.fromName("fluency", "outline", "chevron-down")
				end
				_result_1 = _condition
			else
				local _condition = (props.collapsedIcon)
				if _condition == nil then
					_condition = Icons.fromName("fluency", "outline", "chevron-right")
				end
				_result_1 = _condition
			end
			return _result_1
		end)(),
		roundness = 0,
		props = extp({
			UIListLayout = {
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
			},
		}, props.props),
		LayoutOrder = 0,
	}
	for _k, _v in Properties do
		_attributes_1[_k] = _v
	end
	local _exp = Vivid.createElement(Button, _attributes_1)
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.AccordionChildrenContainer
	end
	local _attributes_2 = {
		Name = "AccordionContent",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		Visible = createEffect(function()
			return props.expanded == true
		end),
		LayoutOrder = 1,
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	return Vivid.createElement(Box, _attributes, _exp, Vivid.createElement("frame", _attributes_2, props.children))
end
return {
	Accordion = Accordion,
}
