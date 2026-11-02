-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    25/09/2026 13:32:25
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local onMount = _vivid.onMount
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Label = TS.import(script, script.Parent, "Base").Label
local _Tabs = TS.import(script, script.Parent, "Tabs")
local createTabRoute = _Tabs.createTabRoute
local Tabs = _Tabs.Tabs
local Controls = {
	route = "0",
	tabs = 3,
}
local function TabContent(props)
	local _attributes = {
		Size = UDim2.fromScale(1, 1),
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Label, _attributes)
end
return CreateStory(Controls, function(props)
	local route = createTabRoute()
	onMount(function()
		createEffect(function()
			route.jumpTo(props.route)
		end)
	end)
	return Vivid.createElement(Tabs, {
		route = route,
		tabs = createEffect(function()
			local tabs = {}
			do
				local _index = 0
				local _shouldIncrement = false
				while true do
					local index = _index
					if _shouldIncrement then
						index += 1
					else
						_shouldIncrement = true
					end
					if not (index < props.tabs) then
						break
					end
					tabs[`{index}`] = {
						name = `Tab {index}`,
						content = function()
							return Vivid.createElement(TabContent, {
								Text = `Tab {index} Content`,
							})
						end,
					}
					_index = index
				end
			end
			return tabs
		end)(),
	})
end)
