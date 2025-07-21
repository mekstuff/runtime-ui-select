-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 22:20:02
	
]]
local _vivid = TS.import(script, script.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out")
local createScope = _vivid.createScope
local createState = _vivid.createState
local PluginContextsScope = createScope()
local PluginContexts, setPluginContexts = createState({})
PluginContextsScope.Close()
return {
	PluginContexts = PluginContexts,
	setPluginContexts = setPluginContexts,
}
