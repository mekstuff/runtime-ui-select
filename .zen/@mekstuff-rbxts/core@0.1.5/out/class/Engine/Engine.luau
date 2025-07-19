-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local ConsoleLogPowerHorseEngineRunning = TS.import(script, script.Parent.Parent.Parent, "internal", "debug", "console_debugger").ConsoleLogPowerHorseEngineRunning
--Engine
local ServerScriptServices = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Engine = {
	InitServer = function()
		if game:GetService("RunService"):IsClient() and game:GetService("RunService"):IsRunning() then
			warn("Server cannot be initiated from the client.")
			return nil
		end
		if ServerStorage:FindFirstChild("PHe_SS") == nil then
			local SSStorage = Instance.new("Folder")
			SSStorage.Name = "PHe_SS"
			SSStorage.Parent = ServerStorage
		end
		if Workspace:FindFirstChild("PHe_WS") == nil then
			local WSStorage = Instance.new("Folder")
			WSStorage.Name = "PHe_WS"
			WSStorage.Parent = Workspace
		end
		if ServerScriptServices:FindFirstChild("PHe_Server") == nil then
			local ServerScripts = Instance.new("Folder")
			ServerScripts.Name = "PHe_Server"
			ServerScripts.Parent = ServerScriptServices
		end
		if ReplicatedStorage:FindFirstChild("PHe_RS") == nil then
			local RSStorage = Instance.new("Folder")
			RSStorage.Name = "PHe_RS"
			RSStorage.Parent = ReplicatedStorage
		end
		ConsoleLogPowerHorseEngineRunning()
	end,
	FetchReplicatedStorage = function(TargetSubContainer)
		local Container = ReplicatedStorage:WaitForChild("PHe_RS")
		local _targetSubContainer = TargetSubContainer
		if not (type(_targetSubContainer) == "string") then
			return Container
		end
		local Exists = Container:FindFirstChild(TargetSubContainer)
		if Exists then
			return Exists
		end
		local NewSubContainer = Instance.new("Folder")
		NewSubContainer.Name = TargetSubContainer
		NewSubContainer.Parent = Container
		return NewSubContainer
	end,
	FetchWorkspaceStorage = function(TargetSubContainer)
		local Container = Workspace:WaitForChild("PHe_WS")
		local _targetSubContainer = TargetSubContainer
		if not (type(_targetSubContainer) == "string") then
			return Container
		end
		local Exists = Container:FindFirstChild(TargetSubContainer)
		if Exists then
			return Exists
		end
		local NewSubContainer = Instance.new("Folder")
		NewSubContainer.Name = TargetSubContainer
		NewSubContainer.Parent = Container
		return NewSubContainer
	end,
	FetchServerStorage = function(TargetSubContainer)
		local Container = ServerStorage:WaitForChild("PHe_SS")
		local _targetSubContainer = TargetSubContainer
		if not (type(_targetSubContainer) == "string") then
			return Container
		end
		local Exists = Container:FindFirstChild(TargetSubContainer)
		if Exists then
			return Exists
		end
		local NewSubContainer = Instance.new("Folder")
		NewSubContainer.Name = TargetSubContainer
		NewSubContainer.Parent = Container
		return NewSubContainer
	end,
	FetchServerScripts = function(TargetSubContainer)
		local Container = ServerScriptServices:WaitForChild("PHe_Server")
		local _targetSubContainer = TargetSubContainer
		if not (type(_targetSubContainer) == "string") then
			return Container
		end
		local Exists = Container:FindFirstChild(TargetSubContainer)
		if Exists then
			return Exists
		end
		local NewSubContainer = Instance.new("Folder")
		NewSubContainer.Name = TargetSubContainer
		NewSubContainer.Parent = Container
		return NewSubContainer
	end,
}
--start engine
if RunService:IsServer() or (RunService:IsClient() and RunService:IsRunning() == false) then
	Engine.InitServer()
end
return {
	Engine = Engine,
}
