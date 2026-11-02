-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    01/01/2025 19:31:40
	
]]
local createElement = TS.import(script, script.Parent, "createElement").createElement
local function createRoot(Callback)
	return createElement(Callback, nil, nil)
end
return {
	createRoot = createRoot,
}
