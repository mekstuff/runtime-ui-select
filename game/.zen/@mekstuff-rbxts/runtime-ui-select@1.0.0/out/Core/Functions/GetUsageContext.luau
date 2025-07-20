-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 22:13:36
	
]]
local RunService = game:GetService("RunService")
local function GetIsStudio()
	return RunService:IsStudio()
end
local function GetIsClient()
	return RunService:IsClient()
end
local function GetIsRunningSession()
	return RunService:IsEdit() == false and GetIsStudio() == true and GetIsClient() == true
end
local function GetIsRunningSessionServer()
	return RunService:IsEdit() == false and GetIsStudio() == true and GetIsClient() == false
end
local function GetIsNonPluginEnv()
	if GetIsStudio() == false then
		return true
	end
	return script:FindFirstAncestorWhichIsA("Plugin") == nil
end
return {
	GetIsStudio = GetIsStudio,
	GetIsClient = GetIsClient,
	GetIsRunningSession = GetIsRunningSession,
	GetIsRunningSessionServer = GetIsRunningSessionServer,
	GetIsNonPluginEnv = GetIsNonPluginEnv,
}
