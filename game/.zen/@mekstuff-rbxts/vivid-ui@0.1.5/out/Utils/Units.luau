-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:34:03
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local createScope = _vivid.createScope
local createState = _vivid.createState
local UnitsContextScope = createScope()
local Units, setUnits, UnitsState = createState({
	BaseOffsetWidth = 40,
	BaseOffsetHeight = 24,
	BaseTextSize = 8,
})
UnitsContextScope.Close()
return {
	Units = Units,
	setUnits = setUnits,
	UnitsState = UnitsState,
}
