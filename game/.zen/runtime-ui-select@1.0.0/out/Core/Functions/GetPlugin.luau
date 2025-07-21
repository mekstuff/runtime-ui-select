-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 22:19:24
	
]]
local use = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out").use
local PluginContexts = TS.import(script, script.Parent.Parent.Parent, "Contexts", "PluginContexts").PluginContexts
local function GetPlugin()
	local Plugin = use(function()
		return PluginContexts().plugin
	end)
	assert(Plugin, "Plugin not assigned.")
	return Plugin
end
return {
	GetPlugin = GetPlugin,
}
