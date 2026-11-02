-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 19:18:52
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local clearScopes = _vivid.clearScopes
local StoryAdapters = _vivid.StoryAdapters
local withProps = _vivid.withProps
local function CreateStory(controls, render)
	return StoryAdapters.UILabs(controls, function(props, children)
		-- const nProps = withProps(props, true) as Partial<typeof props>;
		-- delete nProps.converted;
		-- delete nProps.inputListener;
		-- delete nProps.setCleanupFunction;
		-- delete nProps.subscribe;
		-- delete nProps.target;
		-- delete nProps.controls;
		props.setCleanupFunction(function()
			clearScopes()
		end)
		return Vivid.createElement("frame", {
			AnchorPoint = Vector2.new(0.5),
			Position = UDim2.fromScale(0.5),
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 1),
		}, Vivid.createElement("uilistlayout", {
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, 30),
		}), render(withProps(props), children))
	end)
end
return {
	CreateStory = CreateStory,
}
