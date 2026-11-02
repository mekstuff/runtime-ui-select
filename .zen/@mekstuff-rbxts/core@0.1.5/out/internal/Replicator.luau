-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local exports = {}
local GetIsInReplicationEnvironment = TS.import(script, script.Parent, "functions", "GetIsInReplicationEnvironment").GetIsInReplicationEnvironment
local GetPseudoById = TS.import(script, script.Parent, "functions", "GetPseudoById").GetPseudoById
local RunService = game:GetService("RunService")
local IsInServerReplicationEnvironment = RunService:IsServer() and GetIsInReplicationEnvironment()
exports.ReplicatorScript = (if IsInServerReplicationEnvironment then (script.Parent:WaitForChild("Pseudo-Replicator-Client")) else nil)
exports.ReplicatorScriptPointer = (if IsInServerReplicationEnvironment then Instance.new("ObjectValue") else nil)
exports.ReplicatorTransmitterRemote = (if IsInServerReplicationEnvironment then Instance.new("RemoteEvent") else nil)
exports.ReplicatorScriptRemote = (if IsInServerReplicationEnvironment then Instance.new("RemoteEvent") else nil)
if IsInServerReplicationEnvironment then
	exports.ReplicatorScriptPointer.Name = "ReplicatorScriptPointer"
	exports.ReplicatorScriptPointer.Value = script
	exports.ReplicatorScriptPointer.Parent = exports.ReplicatorScript
	exports.ReplicatorTransmitterRemote = Instance.new("RemoteEvent")
	exports.ReplicatorTransmitterRemote.Name = "ReplicatorTransmitterRemote"
	exports.ReplicatorTransmitterRemote.Parent = script
	exports.ReplicatorTransmitterRemote.OnServerEvent:Connect(function(Player, PseudoReplicatorId, TransmitterId, Acton, ...)
		local Data = { ... }
		local _acton = Acton
		if not (type(_acton) == "string") then
			warn(`[PowerHorse Replicator] {Player} sent an invalid Acton type to the server. got {Acton}, Request dropped`)
			return nil
		end
		local _transmitterId = TransmitterId
		if not (type(_transmitterId) == "string") then
			warn(`[PowerHorse Replicator] {Player} sent an invalid TransmitterId type to the server. got {TransmitterId}, Request dropped`)
			return nil
		end
		local _pseudoReplicatorId = PseudoReplicatorId
		if not (type(_pseudoReplicatorId) == "string") then
			warn(`[PowerHorse Replicator] {Player} sent an invalid PseudoReplicatorId type to the server. got {PseudoReplicatorId}, Request dropped`)
			return nil
		end
		local TargetPseudoReplicator = GetPseudoById(PseudoReplicatorId)
		if TargetPseudoReplicator == nil then
			warn(`[PowerHorse Replicator] {Player} sent an invalid PseudoReplicatorId (does not exist) to the server. got {PseudoReplicatorId}, Request dropped`)
			return nil
		end
		if TargetPseudoReplicator:IsA("PseudoReplicator") ~= true then
			warn(`[PowerHorse Replicator] {Player} sent an invalid PseudoReplicatorId (not a PseudoReplicator) to the server. got {PseudoReplicatorId}, Request dropped`)
			return nil
		end
		TargetPseudoReplicator:ResolveTransmitter(TransmitterId, if Acton == "success" then true else false, unpack(Data))
	end)
	exports.ReplicatorScriptRemote = Instance.new("RemoteEvent")
	exports.ReplicatorScriptRemote.Name = "ReplicatorScriptRemote"
	exports.ReplicatorScriptRemote.Parent = script
	exports.ReplicatorScriptRemote.OnServerEvent:Connect(function(Player, eventType, ...)
		local args = { ... }
		local _eventType = eventType
		if not (type(_eventType) == "string") then
			return nil
		end
		if eventType == "requestFunction" then
			local funcName = args[1]
			local targetPseudoId = args[2]
			if type(funcName) == "string" and type(targetPseudoId) == "string" then
				local _value = (string.match(funcName, "^_"))
				if _value ~= 0 and _value == _value and _value ~= "" and _value then
					-- private method cannot be queried
					return nil
				end
				local targetPseudo = GetPseudoById(targetPseudoId)
				if not targetPseudo then
					return nil
				end
				local success, results = pcall(function()
					local activePseudoClientReplicator = targetPseudo._dev.get("activePseudoClientReplicator")
					if not activePseudoClientReplicator then
						error("Not an active replicated item.")
					end
					activePseudoClientReplicator:_createCommunicationBindable(Player, funcName)
				end)
				if not success then
					warn(results)
				end
			end
		end
	end)
end
return exports
