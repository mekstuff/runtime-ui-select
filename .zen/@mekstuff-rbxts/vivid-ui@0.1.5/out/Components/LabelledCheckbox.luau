-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:39:19
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local _Base = TS.import(script, script.Parent, "Base")
local Checkbox = _Base.Checkbox
local Label = _Base.Label
local function LabelledCheckbox(props)
	local _exp = Vivid.createElement("uilistlayout", {
		Padding = UDim.new(0, 8),
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
	})
	local _attributes = {
		Activated = props.onClick,
		Active = true,
		Interactable = true,
	}
	local _attribute = props.labelProps
	if _attribute then
		for _k, _v in _attribute do
			_attributes[_k] = _v
		end
	end
	local _exp_1 = Vivid.createElement(Label, _attributes)
	local _attributes_1 = {
		Activated = props.onClick,
	}
	for _k, _v in props.checkboxProps do
		_attributes_1[_k] = _v
	end
	return Vivid.createElement("frame", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}, _exp, _exp_1, Vivid.createElement(Checkbox, _attributes_1))
end
return {
	LabelledCheckbox = LabelledCheckbox,
}
