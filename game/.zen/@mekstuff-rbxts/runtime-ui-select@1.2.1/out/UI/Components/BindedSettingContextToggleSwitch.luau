-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
		Typed with ❤️ @mekstuff
		02/07/2025 22:12:38
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Case = _vivid.Case
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local Switch = _vivid.Switch
local use = _vivid.use
local _vivid_ui = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out)
local SettingContent = _vivid_ui.SettingContent
local ToggleSwitch = _vivid_ui.ToggleSwitch
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local Constants = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Constants").Constants
local UnavailableFeature = TS.import(script, script.Parent, "UnavailableFeature").UnavailableFeature
local function BindedSettingContextToggleSwitch(props)
	local SettingContextObject = SettingsContext[use(function()
		return props.TargetSettingContext
	end)]
	local _arg0 = use(function()
		return SettingContextObject.get()
	end)
	local _arg0_1 = type(_arg0) == "boolean"
	assert(_arg0_1, "SettingContextObject not a boolean.")
	return Vivid.createElement("frame", {
		tags = { Constants.MainWidgetToolTipCollectionId },
		attributes = {
			[Constants.MainWidgetToolTipCollectionId] = createEffect(function()
				local _result
				if props.Dependencies or props.InverseDependencies ~= nil then
					local _array = {}
					local _length = #_array
					local _array_1 = (props.Dependencies or {})
					local _Length = #_array_1
					table.move(_array_1, 1, _Length, _length + 1, _array)
					_length += _Length
					local _result_1 = props.InverseDependencies
					if _result_1 ~= nil then
						-- ▼ ReadonlyArray.map ▼
						local _newValue = table.create(#_result_1)
						local _callback = function(InverseDep)
							return `Not {InverseDep}`
						end
						for _k, _v in _result_1 do
							_newValue[_k] = _callback(_v, _k - 1, _result_1)
						end
						-- ▲ ReadonlyArray.map ▲
						_result_1 = _newValue
					end
					local _condition = _result_1
					if _condition == nil then
						_condition = {}
					end
					table.move(_condition, 1, #_condition, _length + 1, _array)
					_result = `Requires: {table.concat(_array, ", ")}`
				else
					_result = nil
				end
				local DependenciesString = _result
				-- return (
				if props.ToolTip == nil then
					local _condition = DependenciesString
					if _condition == nil then
						_condition = ""
					end
					return _condition
				end
				if DependenciesString == nil then
					return props.ToolTip
				end
				return props.ToolTip .. `\n\n{DependenciesString}`
			end)(),
			[Constants.SearchFilterMatchAttribute] = props.Text,
		},
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
	}, Vivid.createElement(SettingContent, {
		titleText = props.Text,
		scaleDistribution = 0.8,
		hideSplitter = props.hideSplitter,
	}, Vivid.createElement(Switch, {
		conditional = createEffect(function()
			return props.UnavailableFeature == true
		end)(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		return Vivid.createElement(UnavailableFeature)
	end), Vivid.createElement(Case, {
		condition = false,
	}, function()
		return Vivid.createElement(ToggleSwitch, {
			toggled = SettingContextObject.get(),
			disabled = createEffect(function()
				if props.Dependencies ~= nil then
					for _, Dependency in pairs(props.Dependencies) do
						if SettingsContext[Dependency].get() == false then
							local oldState = false
							SettingContextObject.set(function(old)
								oldState = old
								return false
							end)
							createCleanup(function(isDestroying)
								if isDestroying ~= 0 and isDestroying == isDestroying and isDestroying ~= "" and isDestroying then
									return nil
								end
								SettingContextObject.set(oldState)
							end)
							return true
						end
					end
				end
				if props.InverseDependencies ~= nil then
					for _, InverseDependency in pairs(props.InverseDependencies) do
						if SettingsContext[InverseDependency].get() == true then
							local oldState = false
							SettingContextObject.set(function(old)
								oldState = old
								return false
							end)
							createCleanup(function(isDestroying)
								if isDestroying ~= 0 and isDestroying == isDestroying and isDestroying ~= "" and isDestroying then
									return nil
								end
								SettingContextObject.set(oldState)
							end)
							return true
						end
					end
				end
				return false
			end)(),
			Activated = function()
				SettingContextObject.set(function(old)
					return not old
				end)
			end,
		})
	end))))
end
return {
	BindedSettingContextToggleSwitch = BindedSettingContextToggleSwitch,
}
