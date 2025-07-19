-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    01/06/2025 13:22:16
	
]]
local FluencyIcons = TS.import(script, script, "FluencyIcons").FluencyIcons
local LibraryMap = {
	fluency = FluencyIcons,
}
local Icons = {
	fromName = function(Library, Category, Icon)
		return LibraryMap[Library][Category][Icon]
	end,
	fluency = LibraryMap.fluency,
}
return {
	Icons = Icons,
}
