-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Engine = TS.import(script, script.Parent.Parent, "Engine", "Engine").Engine
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local Servant = TS.import(script, script.Parent.Parent, "Servant", "Servant").Servant
local SyncedContent = TS.import(script, script.Parent, "SyncedContent").SyncedContent
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local IsServer = RunService:IsServer()
local SyncedEntries = {}
local SyncingMethod
do
	local _inverse = {}
	SyncingMethod = setmetatable({}, {
		__index = _inverse,
	})
	SyncingMethod.default = 0
	_inverse[0] = "default"
	SyncingMethod.attr = 1
	_inverse[1] = "attr"
end
local SyncerUsageClass
do
	local super = Pseudo
	SyncerUsageClass = setmetatable({}, {
		__tostring = function()
			return "SyncerUsageClass"
		end,
		__index = super,
	})
	SyncerUsageClass.__index = SyncerUsageClass
	function SyncerUsageClass.new(...)
		local self = setmetatable({}, SyncerUsageClass)
		return self:constructor(...) or self
	end
	function SyncerUsageClass:constructor()
		super.constructor(self, "Syncer")
		self.SyncingMethods = SyncingMethod
		local RunService = game:GetService("RunService")
		if RunService:IsServer() and RunService:IsRunning() then
			local ServerCoreSyncerRemote = Instance.new("RemoteEvent")
			self._ServerCoreSyncerRemote = ServerCoreSyncerRemote
			ServerCoreSyncerRemote.Name = `CoreSync-{self.ClassName}`
			ServerCoreSyncerRemote.Parent = Engine.FetchReplicatedStorage()
			ServerCoreSyncerRemote.OnServerEvent:Connect(function(Player, Arg0, TargetSyncId)
				local _arg0 = Arg0
				if not (type(_arg0) == "string") then
					return nil
				end
				local _targetSyncId = TargetSyncId
				if not (type(_targetSyncId) == "string") then
					return nil
				end
				if Arg0 == "$catchAll" then
					local CatchedItems = self:_getSyncedCatchData(TargetSyncId, Player)
					for key, value in pairs(CatchedItems) do
						ServerCoreSyncerRemote:FireClient(Player, "$initialize", key, value)
					end
					return nil
				end
				if Arg0 ~= "$initialize" then
					return nil
				end
				ServerCoreSyncerRemote:FireClient(Player, "$initialize", TargetSyncId, (self:_getSyncedDataForKey(TargetSyncId, Player)))
			end)
			Players.PlayerRemoving:Connect(function(Player)
				if not SyncedEntries then
					return nil
				end
				for _, b in pairs(SyncedEntries) do
					for c in pairs(b) do
						if c == Player.UserId then
							b[c] = nil
							continue
						end
					end
				end
			end)
		end
	end
	function SyncerUsageClass:_getSyncedDataForKey(SyncId, Key)
		self:assert(IsServer, `_getSyncedDataForKey can only be called by the server.`)
		if SyncedEntries[SyncId] == nil then
			return nil
		end
		local sid = SyncedEntries[SyncId]
		local _key = Key
		if type(_key) == "number" then
			local q = sid[Key]
			if q ~= nil then
				return q
			end
		else
			local q = sid[Key.UserId]
			if q ~= nil then
				return q
			end
		end
		return sid["*"]
	end
	function SyncerUsageClass:_getSyncedCatchData(CatchAll, Key)
		local datas = {}
		for entryKey in pairs(SyncedEntries) do
			local _arg0 = `^{CatchAll}/.+`
			local isCatch = (string.match(entryKey, _arg0))
			if type(isCatch) == "string" then
				datas[isCatch] = self:_getSyncedDataForKey(isCatch, Key)
			end
		end
		return datas
	end
	function SyncerUsageClass:GetSynced(SyncId, Target)
		return self:_getSyncedDataForKey(SyncId, Target)
	end
	function SyncerUsageClass:Sync(SyncId, SyncData, SyncTo, SyncingMethod)
		if SyncTo == nil then
			SyncTo = "*"
		end
		if SyncingMethod == nil then
			SyncingMethod = self.SyncingMethods.default
		end
		self:assert(IsServer, `Sync can only be called by the server.`)
		if SyncTo == "*" then
			SyncedEntries[SyncId] = {}
			SyncedEntries[SyncId][SyncTo] = SyncData
			local _exp = Players:GetPlayers()
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(Player)
				self._ServerCoreSyncerRemote:FireClient(Player, "$update", SyncId, (self:_getSyncedDataForKey(SyncId, Player)))
			end
			for _k, _v in _exp do
				_callback(_v, _k - 1, _exp)
			end
			-- ▲ ReadonlyArray.forEach ▲
		else
			local handleSyncToEntry = function(input)
				SyncedEntries[SyncId] = SyncedEntries[SyncId] or {}
				local _input = input
				local k = if typeof(_input) == "Instance" then input.UserId else input
				SyncedEntries[SyncId][k] = SyncData
				local _input_1 = input
				local p = if typeof(_input_1) == "Instance" then input else Players:GetPlayerByUserId(input)
				if not p then
					self:warn(`Could not resolve input to handleSyncToEntry for "{input}". Player Instance was not resolved.`)
					return nil
				end
				self._ServerCoreSyncerRemote:FireClient(p, "$update", SyncId, (self:_getSyncedDataForKey(SyncId, input)))
			end
			local _syncTo = SyncTo
			if type(_syncTo) == "table" then
				for _k, _v in SyncTo do
					handleSyncToEntry(_v, _k - 1, SyncTo)
				end
			else
				handleSyncToEntry(SyncTo)
			end
		end
	end
	function SyncerUsageClass:useSync(SyncId, Callback)
		self:assert(not IsServer, `useSync can only be called by the server.`)
		local _SyncedContent = SyncedContent.new(SyncId, self)
		if Callback then
			Callback(_SyncedContent)
		end
		return _SyncedContent
	end
	function SyncerUsageClass:useCatch(CatchId, Callback)
		local ServerCoreSyncerRemote = Engine.FetchReplicatedStorage():WaitForChild(`CoreSync-{self.ClassName}`)
		local useCatchServant = Servant.new()
		local CatchEntries = {}
		useCatchServant._dev._internal_catchentries = CatchEntries
		useCatchServant:Keep(ServerCoreSyncerRemote.OnClientEvent:Connect(function(eventType, ServerSentSyncId, v)
			local _eventType = eventType
			if not (type(_eventType) == "string") then
				return nil
			end
			if eventType ~= "$initialize" then
				return nil
			end
			local _serverSentSyncId = ServerSentSyncId
			if not (type(_serverSentSyncId) == "string") then
				return nil
			end
			local _serverSentSyncId_1 = ServerSentSyncId
			local _arg0 = `^{CatchId}/(.+)`
			local isCatch = (string.match(_serverSentSyncId_1, _arg0))
			if not (type(isCatch) == "string") then
				return nil
			end
			if CatchEntries[isCatch] then
				CatchEntries[isCatch].Value = v
				return nil
			end
			local Synced = SyncedContent.new(`{CatchId}/{isCatch}`, self, v)
			CatchEntries[isCatch] = Synced
			Synced.Destroying:Connect(function()
				CatchEntries[isCatch] = nil
			end)
			Callback(Synced, isCatch)
		end))
		-- @todo- Maybe instead of querying the server evertime a new useCatch is created, we can possible use data from the client from previous existing catchAll contents
		-- ^^ will only be useful in cases where two of the same catchAll ids are used.
		ServerCoreSyncerRemote:FireServer("$catchAll", CatchId)
		return useCatchServant
	end
end
local Syncer = SyncerUsageClass.new()
local default = Syncer
return {
	SyncingMethod = SyncingMethod,
	SyncerUsageClass = SyncerUsageClass,
	Syncer = Syncer,
	default = default,
}
