-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local Image = TS.import(script, script.Parent, "Image").Image
local CreateStory = TS.import(script, script.Parent.Parent.Parent, "Utils", "CreateStory").CreateStory
local Controls = {
	Image = "",
}
return CreateStory(Controls, function(props)
	local _attributes = table.clone(props)
	setmetatable(_attributes, nil)
	return Vivid.createElement(Image, _attributes)
end)
