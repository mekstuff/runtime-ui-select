-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    17/07/2025 22:54:38
	
]]
local RunService = game:GetService("RunService")
local function GetIsInReplicationEnvironment()
	return script:FindFirstAncestorWhichIsA("Plugin") == nil
end
return {
	GetIsInReplicationEnvironment = GetIsInReplicationEnvironment,
}
