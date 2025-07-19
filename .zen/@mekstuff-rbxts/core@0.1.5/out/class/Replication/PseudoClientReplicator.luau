-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	*
	 * Olanzo @ mekstuff
	 
]]
local Engine = TS.import(script, script.Parent.Parent, "Engine", "Engine").Engine
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local ReplicatorScriptRemote = TS.import(script, script.Parent.Parent.Parent, "internal", "Replicator").ReplicatorScriptRemote
local _getCanPropertyReplicateBasedOnReplicationInfo = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "GetCanPropertyReplicateBasedOnReplicationInfo")._getCanPropertyReplicateBasedOnReplicationInfo
local Players = game:GetService("Players")
local ServerClientInitializersID = `@PowerHorseEngine.PCR.ID`
local function GetClientInitializersContainer(Player)
	local ClientInitializersContainer = Player:FindFirstChild(ServerClientInitializersID)
	if ClientInitializersContainer == nil then
		ClientInitializersContainer = Instance.new("Configuration")
		ClientInitializersContainer.Name = ServerClientInitializersID
		ClientInitializersContainer.Parent = Player
	end
	return ClientInitializersContainer
end
local function GetClientInitializersContainerStorageIdentifier(Player, PseudoRep, PseudoRepOrigin)
	return GetClientInitializersContainer(Player):FindFirstChild(`{PseudoRep:GetIdAsync()}-{PseudoRepOrigin:GetIdAsync()}`)
end
--[[
	*
	 * `PseudoClientReplicator` is a Pseudo class that is created whenever Replication is enabled within a Pseudo class. It is passed as a second
	 * argument to both the $server and $client replication constructor functions.
	 
]]
local PseudoClientReplicator
do
	local super = Pseudo
	PseudoClientReplicator = setmetatable({}, {
		__tostring = function()
			return "PseudoClientReplicator"
		end,
		__index = super,
	})
	PseudoClientReplicator.__index = PseudoClientReplicator
	function PseudoClientReplicator.new(...)
		local self = setmetatable({}, PseudoClientReplicator)
		return self:constructor(...) or self
	end
	function PseudoClientReplicator:constructor(pseudoOriginator)
		super.constructor(self, "PseudoClientReplicator")
		self.pseudoOriginator = pseudoOriginator
		self._initialized = nil
		self._internal__totalPCRUsageEntries = {}
		self.Disconnected = self.Destroying
		pseudoOriginator._dev.activePseudoClientReplicator = self
		local f = Engine.FetchReplicatedStorage():FindFirstChild("PseudoClientReplicators")
		if not f then
			f = Instance.new("Folder")
			f.Name = "PseudoClientReplicators"
			f.Parent = Engine.FetchReplicatedStorage()
		end
		local ref = f:FindFirstChild(pseudoOriginator:GetIdAsync())
		if not ref then
			self.Name = pseudoOriginator:GetIdAsync()
			self.Parent = f
			ref = self:GetRef()
		end
		self._ref = ref
		self.Destroying:Connect(function()
			pseudoOriginator._dev.activePseudoClientReplicator = nil
			ReplicatorScriptRemote:FireAllClients("remove", self.pseudoOriginator:GetIdAsync())
		end)
		self._dev.insert(pseudoOriginator.Destroying:Connect(function()
			self:Destroy()
		end))
	end
	function PseudoClientReplicator:_initializeClient(client)
		local ClientInitializersContainer = GetClientInitializersContainer(client)
		local StorageIdentifier = GetClientInitializersContainerStorageIdentifier(client, self, self.pseudoOriginator)
		if not StorageIdentifier then
			local NStorageIdentifier = Instance.new("Configuration")
			NStorageIdentifier.Name = `{self:GetIdAsync()}-{self.pseudoOriginator:GetIdAsync()}`
			NStorageIdentifier.Parent = ClientInitializersContainer
			self._dev.insert(StorageIdentifier)
		else
			return nil
		end
		ReplicatorScriptRemote:FireClient(client, "initialize", self._initialized, self.pseudoOriginator:GetIdAsync(), self._ref)
	end
	function PseudoClientReplicator:GetRemote(RemoteName)
		local _value = (string.match(RemoteName, "Server$"))
		if _value ~= 0 and _value == _value and _value ~= "" and _value then
			self:error(`You cannot get a remote ending with the word "Server". ==>> "{RemoteName}"`)
		end
		local targetRemote = self._ref:FindFirstChild(RemoteName)
		if targetRemote then
			return targetRemote
		end
		self:warn(`GetRemote("{RemoteName}") was called before the Remote existed. .WaitForChild will be used and the thread will yield.`)
		return self._ref:WaitForChild(RemoteName)
	end
	function PseudoClientReplicator:CreateRemote(RemoteName)
		if game:GetService("RunService"):IsClient() then
			self:error(`You can only created Remotes on the server. ==>> CreateRemote("{RemoteName}")`)
		end
		local _value = (string.match(RemoteName, "Server$"))
		if _value ~= 0 and _value == _value and _value ~= "" and _value then
			self:error(`You cannot create a remote ending with the word "Server". ==>> "{RemoteName}"`)
		end
		local targetRemote = self._ref:FindFirstChild(RemoteName)
		if not targetRemote then
			targetRemote = Instance.new("RemoteEvent")
			targetRemote.Name = RemoteName
			targetRemote.Parent = self._ref
		end
		local _condition = (targetRemote:GetAttribute("_totalPCRUsage"))
		if not (_condition ~= 0 and _condition == _condition and _condition) then
			_condition = 0
		end
		local totalUsed = _condition
		targetRemote:SetAttribute("_totalPCRUsage", totalUsed + 1)
		local __internal__totalPCRUsageEntries = self._internal__totalPCRUsageEntries
		local _targetRemote = targetRemote
		if __internal__totalPCRUsageEntries[_targetRemote] ~= nil then
			return targetRemote
		end
		local __internal__totalPCRUsageEntries_1 = self._internal__totalPCRUsageEntries
		local _targetRemote_1 = targetRemote
		__internal__totalPCRUsageEntries_1[_targetRemote_1] = true
		self.Destroying:Connect(function()
			local __internal__totalPCRUsageEntries_2 = self._internal__totalPCRUsageEntries
			local _targetRemote_2 = targetRemote
			__internal__totalPCRUsageEntries_2[_targetRemote_2] = nil
			local _totalPCRUsage = targetRemote:GetAttribute("_totalPCRUsage")
			if not (_totalPCRUsage ~= 0 and _totalPCRUsage == _totalPCRUsage and _totalPCRUsage) then
				return nil
			end
			if _totalPCRUsage == 1 then
				targetRemote:Destroy()
				return nil
			end
			targetRemote:SetAttribute("_totalPCRUsage", _totalPCRUsage - 1)
		end)
		return targetRemote
	end
	function PseudoClientReplicator:InitializeClients(clientReplicator, targetClients, replicationSerializer)
		if self._initialized then
			return nil
		end
		self._initialized = clientReplicator
		local getValueForReplication = function(value, key)
			local _value = value
			local _condition = typeof(_value) == "Instance"
			if not _condition then
				local _value_1 = value
				_condition = type(_value_1) == "table"
			end
			if _condition then
				local s, r = pcall(function()
					if replicationSerializer ~= 0 and replicationSerializer == replicationSerializer and replicationSerializer ~= "" and replicationSerializer then
						return `__encoded-serializer` .. (replicationSerializer:Compress(replicationSerializer:Encode(value)))
					else
						return nil
					end
				end)
				if not s then
					self:warn(`{self} [{self.pseudoOriginator}] cannot transmit key "{key}" with the value: "{value}" for Replication as it cannot be Replicated, You should use a Serializer to pass this data using the Serializer argument of EnableReplication. ==>> {r}`)
					return nil
				end
				return r
			end
			return value
		end
		for key, value in pairs(self.pseudoOriginator:_getCurrentProperties(nil, nil, nil, nil, true)) do
			if not _getCanPropertyReplicateBasedOnReplicationInfo(self.pseudoOriginator, key) then
				continue
			end
			self._ref:SetAttribute(key, getValueForReplication(value, key))
		end
		self._dev.set("_propertyChanged", self.pseudoOriginator.PropertyChanged:Connect(function(key, value)
			if not _getCanPropertyReplicateBasedOnReplicationInfo(self.pseudoOriginator, key) then
				return nil
			end
			self._ref:SetAttribute(key, getValueForReplication(value, key))
		end))
		local _exp = Players:GetPlayers()
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(Player)
			local _condition = targetClients
			if _condition then
				local _targetClients = targetClients
				local _player = Player
				_condition = (table.find(_targetClients, _player) or 0) - 1 == -1
			end
			if _condition then
				return nil
			end
			self:_initializeClient(Player)
		end
		for _k, _v in _exp do
			_callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
		self._dev.set("_requestInitialized", ReplicatorScriptRemote.OnServerEvent:Connect(function(Player, param)
			if param ~= "initialize" then
				return nil
			end
			local _condition = targetClients
			if _condition then
				local _targetClients = targetClients
				local _player = Player
				_condition = (table.find(_targetClients, _player) or 0) - 1 == -1
			end
			if _condition then
				return nil
			end
			self:_initializeClient(Player)
		end))
	end
	function PseudoClientReplicator:_createCommunicationBindable(PlayerWhoRequested, funcName)
		if Engine.FetchReplicatedStorage():WaitForChild("PseudoClientReplicators"):WaitForChild(self.pseudoOriginator:GetIdAsync()):FindFirstChild(funcName) then
			return nil
		end
		local HasStorageIdentifier = GetClientInitializersContainerStorageIdentifier(PlayerWhoRequested, self, self.pseudoOriginator)
		if HasStorageIdentifier == nil then
			self:warn(`{PlayerWhoRequested} attempted to access a Communication Bindable that they don't have access to. Attempt on function "{self.pseudoOriginator}.{funcName}"`)
			return nil
		end
		local bind = Instance.new("RemoteFunction")
		bind.OnServerInvoke = function(Player, ...)
			local args = { ... }
			local HasStorageIdentifier = GetClientInitializersContainerStorageIdentifier(Player, self, self.pseudoOriginator)
			if HasStorageIdentifier == nil then
				self:warn(`{PlayerWhoRequested} attempted to access a Communication Bindable that they don't have access to. Attempt on function "{self.pseudoOriginator}.{funcName}"`)
				return nil
			end
			local r = { (self.pseudoOriginator)[funcName](self.pseudoOriginator, Player, unpack(args)) }
			if TS.Promise.is(r[1]) then
				-- return r[0].await();
				return r[1]:expect()
			end
			return unpack(r)
		end
		bind.Name = funcName
		bind.Parent = Engine.FetchReplicatedStorage():WaitForChild("PseudoClientReplicators"):WaitForChild(self.pseudoOriginator:GetIdAsync())
	end
end
return {
	PseudoClientReplicator = PseudoClientReplicator,
}
