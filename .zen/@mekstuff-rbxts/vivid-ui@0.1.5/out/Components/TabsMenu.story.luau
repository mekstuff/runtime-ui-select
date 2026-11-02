-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 20:42:27
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local TabsMenu = TS.import(script, script.Parent, "TabsMenu").TabsMenu
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Label = TS.import(script, script.Parent, "Base").Label
local Controls = {
	highlighterColor3 = Color3.fromRGB(),
	tabs = 3,
}
local function TabMenuContent(props)
	local _attributes = {
		Size = UDim2.fromScale(1, 1),
	}
	for _k, _v in props do
		_attributes[_k] = _v
	end
	return Vivid.createElement(Label, _attributes)
end
return CreateStory(Controls, function(props)
	return Vivid.createElement(TabsMenu, {
		highlighterColor3 = props.highlighterColor3,
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
					local _arg0 = {
						title = `Tab {index + 1}`,
						content = function()
							return Vivid.createElement(TabMenuContent, {
								Text = `Tab {index + 1} Content`,
							})
						end,
					}
					table.insert(tabs, _arg0)
					_index = index
				end
			end
			return tabs
		end)(),
	})
end)
