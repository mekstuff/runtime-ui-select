-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    22/07/2025 12:48:39
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createRef = _vivid.createRef
local Input = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out).Input
local _SettingsContexts = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts")
local HoverDetectionAccuracyNumberRange = _SettingsContexts.HoverDetectionAccuracyNumberRange
local SettingsContext = _SettingsContexts.SettingsContext
local RoundTo2DecimalPlaces = TS.import(script, script.Parent.Parent.Parent, "Core", "Functions", "Format").RoundTo2DecimalPlaces
local function HoverAccuracyInput()
	local InputRef = createRef()
	createEffect(function()
		local TextBox = InputRef()
		if TextBox == nil then
			return nil
		end
		local FocusLostListener = TextBox.FocusLost:Connect(function()
			local TargetValue = tonumber(TextBox.Text)
			TextBox.Text = ""
			if TargetValue == nil then
				return nil
			end
			SettingsContext.HoverDetectionAccuracy.set(math.clamp(RoundTo2DecimalPlaces(TargetValue), HoverDetectionAccuracyNumberRange.Min, HoverDetectionAccuracyNumberRange.Max))
		end)
		createCleanup(function()
			FocusLostListener:Disconnect()
		end)
	end)
	return Vivid.createElement(Input, {
		ref = InputRef,
		Size = UDim2.fromScale(1),
		AutomaticSize = Enum.AutomaticSize.Y,
		TextXAlignment = Enum.TextXAlignment.Center,
		Text = "",
		PlaceholderText = createEffect(function()
			return tostring(SettingsContext.HoverDetectionAccuracy.get())
		end),
	})
end
return {
	HoverAccuracyInput = HoverAccuracyInput,
}
