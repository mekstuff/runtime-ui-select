-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 20:42:27
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local TabsMenu = TS.import(script, script.Parent, "TabsMenu").TabsMenu
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Label = TS.import(script, script.Parent, "Base").Label
local Controls = {
	highlighterColor3 = Color3.fromRGB(),
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
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	_attributes.tabs = { {
		Title = "Tab 1",
		Icon = "rbxassetid://14187732705",
		Content = Vivid.createElement(TabMenuContent, {
			Text = "Tab 1 Content",
		}),
	}, {
		Title = "Tab 2",
		Icon = "rbxassetid://12966399317",
		Content = Vivid.createElement(TabMenuContent, {
			Text = "Tab 2 Content",
		}),
	}, {
		Title = "Tab 3",
		Icon = "rbxassetid://11432842485",
		Content = Vivid.createElement(TabMenuContent, {
			Text = "Tab 3 Content",
		}),
	} }
	return Vivid.createElement(TabsMenu, _attributes)
end)
