-- @mekstuff
-- This script handles replication of pseudo's

local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

if not script:GetAttribute("_clientControlled") then
	--> client now owns this script and its contents.
	if(plugin ~= nil or script:FindFirstAncestorWhichIsA("Plugin") ~= nil) then
		 --> Pseudo-Replicator-Client should not execute in a plugin environment.
		return
	end
	task.defer(function()
		script:SetAttribute("_clientControlled", true)
		script:Clone().Parent = script.Parent
		script:Destroy()
	end)
	return
end

local PHeClientRuntimeFolder = Instance.new("Folder")
PHeClientRuntimeFolder.Name = "PHeClientRuntime"

PHeClientRuntimeFolder.Parent = Players.LocalPlayer:WaitForChild("PlayerScripts")

local Constants = require(script:WaitForChild("Constants"))

local ReplicatorScriptRemote = Constants.ReplicatorScriptRemote :: RemoteEvent
local ReplicatorTransmitterRemote = Constants.ReplicatorTransmitterRemote :: RemoteEvent
local LuaProvider = Constants.LuaProvider
local PseudoModule = Constants.PseudoModule

local PowerHorse = Constants.PowerHorse
local Promise = PowerHorse.Promise

local ProxyCreateFolder = Constants.PseudoModule:WaitForChild("internal"):WaitForChild("proxy-create")
local CreateClientReplicator = LuaProvider.require(ProxyCreateFolder:WaitForChild("CreateClientReplicator")).CreateClientReplicator

local replicated = {}

--> Transmission Remote Listener
ReplicatorTransmitterRemote.OnClientEvent:Connect(
	function(FuncName: string, PseudoReplicatorId: string, PseudoId: string, TransmitterId: string | nil, ...)
		if (replicated[PseudoId] == nil) or (replicated[PseudoId] == true) then
			local Tries = 0
			while true do
				Tries += 1
				task.wait(Tries / 10)
				if (replicated[PseudoId] ~= nil) and (replicated[PseudoId] ~= true) then
					break
				end
				if Tries == 15 then
					PowerHorse:warn(
						`Dropped Transmission request on "{PseudoId}" ({FuncName}). Replicated Pseudo ID "{PseudoId}" does no exist locally.`
					)
					return
				end
			end
		end
		local args = { ... }

		local resultsPacked
		local success, results = pcall(function()
			resultsPacked = { replicated[PseudoId][FuncName](replicated[PseudoId], Players.LocalPlayer, unpack(args)) }
		end)
		if TransmitterId == nil then
			--> No TransmitterId provided, meaning it was sent without expecting a response (TransmitMessage(...))
			if not success then
				PowerHorse:warn(results)
			end
			return
		end
		if not success then
			PowerHorse:warn(results)
			ReplicatorTransmitterRemote:FireServer(PseudoReplicatorId, TransmitterId, "failed", tostring(results))
			return
		end
		ReplicatorTransmitterRemote:FireServer(PseudoReplicatorId, TransmitterId, "success", unpack(resultsPacked))
	end
)

--> Replication Remote Listener
-- @core

-- @todo - Add support for Instances that weren't replicated yet. Server should pass an "IsInstance" param
-- and if the Instance doesn't exist on the client, the client should wait/lookout for when that Instance is created.
local serializer

local GetIsValidDefineFunctionName = LuaProvider.require(
	Constants.PseudoModule
		:WaitForChild("internal")
		:WaitForChild("functions")
		:WaitForChild("GetIsValidDefineFunctionName")
).GetIsValidDefineFunctionName

local function getValue(value)
	if typeof(value) == "string" then
		local m0, m1 = value:match("^(__encoded%-serializer)(.+)")
		if m0 and m1 then
			if serializer then
				return serializer:Decode(serializer:Decompress(m1))
			end
			--[[
			local serializerFolder = PseudoModule.Parent.Parent:FindFirstChild("serializer")
			if not serializerFolder then
				error(
					"Could not find serializer to decode Replicated Pseodo Value! make sure @mekstuff-rbxts/serializer is installed!"
				)
			end
			local out = serializerFolder:WaitForChild("out")
			-- _G[out] = require(serializerFolder.Parent.Parent:WaitForChild("rbxts-lua-provider"):When("Provider"):WaitForChild("include"):WaitForChild("RuntimeLib"))
			serializer = require(out).Serializer.new()
			]]
			serializer = PowerHorse.PKG("serializer").Serializer.new()
			return serializer:Decode(serializer:Decompress(m1))
		end
	end
	return value
end

local function update(targetId, key, value)
	if not replicated[targetId] or replicated[targetId] == true then
		return
	end
	if typeof(key) == "string" and key:match("^_") then
		return
	end
	if key == "pseudoOriginator" or key == "ClassName" or key == "PropertyChanged" then
		return
	end
	replicated[targetId][key] = getValue(value)
end

--[[
local function ReplicatorPlaceholderFunction()
	return
end
]]

local ExposedApiInterface: {
	onReplicatedTargetModuleResolvedEntries: { (data: any, targetid: string) -> any },
} = {
	onReplicatedTargetModuleResolvedEntries = {},
}

ReplicatorScriptRemote.OnClientEvent:Connect(function(eventType: "initialize", ...)
	local args = { ... }
	if eventType == "initialize" then
		local targetId = args[2] :: ModuleScript | table
		if targetId and replicated[targetId] then
			return --> Do not create a new item with the same target id (it was most likely a descendant, the "update" method will handle changes)
		end
		replicated[targetId] = true --> so any incoming requests will be dropped in between creating and setting up the replicated on the client. it will be overwritten to the class below.
		local targetModule = args[1] :: ModuleScript | table
		local PseudoClientReplicator = args[3] :: Folder
		if typeof(targetModule) == "Instance" and targetModule:IsA("ModuleScript") then
			targetModule = LuaProvider.require(targetModule, nil, targetId)
		end

		if
			typeof(targetModule) == "table"
			and typeof(targetModule.default) == "table"
			and targetModule.default.constructor
		then
			targetModule = targetModule.default --> in cases where `export default` is used over `export=`
		end

		local function setupClass(self)

			self._replicationIdentifierKey = targetId
			-- function self:GetServerReplicationId(): string
			-- 	return targetId
			-- end

			local servant = self:CreateServantAsync()
			self._dev.___pseudoreplicator_queryServerCall = function(key, ...)
				local _args = { ... }
				return Promise.new(function(resolve, reject)
					local targetFunction = PseudoClientReplicator:FindFirstChild(key)
					if not targetFunction then
						ReplicatorScriptRemote:FireServer("requestFunction", key, targetId)
						targetFunction = PseudoClientReplicator:WaitForChild(key, 60)
						if not targetFunction then
							reject()
							error(`"{key}" may not be accessible by the client! "{self}"`)
						end
					end
					resolve(targetFunction:InvokeServer(unpack(_args)))
				end)
			end


			if(self:HasReplicator() == false) then
				--> ^ Replicator could've been created by PseudoNext, Since export default new ...() means the Pseudo is created initially on the client THEN given the replicated...
				--> ... data, it's possible to attempt to use the Replicator before this script runs on the object, so PseudoNext will detect that and create the Replicator earlier.
				self.Replicator = CreateClientReplicator(self)
			end
			--[[
			self.Replicator = {
				Define = function(_, _, ...)
					local funcName = debug.info(2, "n")
					if funcName == "Define" then
						--> in cases where funcName is "Define", it's where the replicator has not been replicated fully yet and
						--> the Definition was called by an external source waiting for the Replicator to complete. See Pseudo.ts [_thisTempReplicator]
						funcName = debug.info(3, "n")
					end
					self:assert(
						GetIsValidDefineFunctionName(funcName),
						`Invalid Function binded to Replicator.Define function. Expected lowercase as first letter and "Serer" as last word. got "{funcName}".\ne.g. "runFunctionServer"`
					)

					if not funcName then
						self.error(
							"Cannot Define Replicator method as the function seems to be anonymous and/or has no assigned debug name."
						)
					end
					return self._dev.___pseudoreplicator_queryServerCall(funcName, ...)
				end,
				--> first arg is "this", second arg is the Player Instance (-< Doesn't exist on the client obv.) that only the server version cares about
				Transmit = function(_, _, func, ...)
					return func(...)
				end,

				WithDebounce = ReplicatorPlaceholderFunction,
			}
			]]

			servant:Keep(PseudoClientReplicator.AttributeChanged:Connect(function(attr)
				update(targetId, attr, PseudoClientReplicator:GetAttribute(attr))
			end))

			local _localPseudoClientReplicator = LuaProvider.class(function(_this)
				_this.Disconnected = self.Destroying

				function _this:GetRemote(RemoteName: string): RemoteEvent
					if RemoteName:match("Server$") then
						_this.error(`You cannot get a remote ending with the word "Server". ==>> "${RemoteName}"`)
					end
					local targetRemote = PseudoClientReplicator:FindFirstChild(RemoteName) :: RemoteEvent
					if targetRemote then
						return targetRemote
					end
					_this:warn(
						`GetRemote("${RemoteName}") was called before the Remote existed. .WaitForChild will be used and the thread will yield.`
					)
					return PseudoClientReplicator:WaitForChild(RemoteName) :: RemoteEvent
				end
			end, require(PseudoModule).Pseudo, "PseudoClientReplicator").new()

			servant:Keep(_localPseudoClientReplicator)

			self._dev.__pseudoServantForReplicator = servant

			local function HandleClientFunctions()
				local _replicationClientFunctions = self._dev.OBJECT_PROXY._replicationClientFunctions
				if _replicationClientFunctions ~= nil then
					for _, func in _replicationClientFunctions do
						if func(servant, _localPseudoClientReplicator) ~= nil then
							self:error(
								`Cleanup from $client is no longer possible. Please use the Servant that is passed as an argument for any cleaning up.`
							)
						end
					end
				end
			end

			HandleClientFunctions()

			servant:Keep(self:Observe(function()
				--> for any future "$client" functions that are applied when Replication is already enabled (view PseudoNext.luau __newindex $client/$server)
				local func = self["$client"]
				if func == nil then
					return
				end
				if func(servant, _localPseudoClientReplicator) ~= nil then
					self:error(
						`Cleanup from $client is no longer possible. Please use the Servant that is passed as an argument for any cleaning up.`
					)
				end
			end, { "$client" }))
			self._replicationObserverReady = true
		end

		for _, ReplicatedEntryCallback in ExposedApiInterface.onReplicatedTargetModuleResolvedEntries do
			targetModule = ReplicatedEntryCallback(targetModule, targetId)
		end

		if targetModule and targetModule._dev and (targetModule :: any):IsA("Pseudo") then
			if replicated[targetId] == false then -- got destroyed before client could replicate.
				targetModule:Destroy()
				return
			end
			setupClass(targetModule)
			replicated[targetId] = targetModule
		else
			if replicated[targetId] == false then -- got destroyed before client could replicate.
				return
			end
			--> use "customClass" over "class" since we need to setup some values before constructor is called.
			replicated[targetId] = LuaProvider.customClass(function(self)
				
			end, function(self)
				setupClass(self)
			end, targetModule).new()
		end

		for attr in PseudoClientReplicator:GetAttributes() do
			update(targetId, attr, PseudoClientReplicator:GetAttribute(attr))
		end
	end

	if eventType == "remove" then
		local targetId = args[1] :: ModuleScript | table
		if not replicated[targetId] then
			return
		end
		if replicated[targetId] == true then
			replicated[targetId] = false
			return
		end
		replicated[targetId]:Destroy()
		replicated[targetId] = nil
	end
end)

--> External API
-- local PowerHorseClientExternalApi = {}
local ExternalModuleApiTag = "PowerHorse.ClientRuntimeApi"

local function assert(condition, err)
	if not condition then
		PowerHorse.error(`[{ExternalModuleApiTag}] {err}`)
	end
end

local ApiEntriesFolder = Instance.new("Folder")
ApiEntriesFolder.Name = ".api"
ApiEntriesFolder.Parent = PHeClientRuntimeFolder
local function GetUniqueApi(EntryServant): (string, any)
	local GUID = HttpService:GenerateGUID(true)
	local ApiFileEntry = Instance.new("StringValue")
	ApiFileEntry.Name = GUID
	ApiFileEntry.Value = EntryServant:GetIdAsync()
	ApiFileEntry.Parent = ApiEntriesFolder

	EntryServant:Keep(ApiFileEntry)

	-- View PseudoNext.d.ts "PowerHorseApiRuntimeClient" for type info.
	local Api = {
		ApiKey = GUID,
		onReplicatedTargetModuleResolved = function(Callback)
			local Servant = PowerHorse.Servant.new()
			assert(typeof(Callback) == "function", `function expected, got ${typeof(Callback)}`)
			table.insert(ExposedApiInterface.onReplicatedTargetModuleResolvedEntries, Callback)

			Servant:Keep(function()
				table.remove(
					ExposedApiInterface.onReplicatedTargetModuleResolvedEntries,
					table.find(ExposedApiInterface.onReplicatedTargetModuleResolvedEntries, Callback)
				)
			end)

			EntryServant:Keep(Servant)
			return Servant
		end,
	}
	return GUID, Api
end

local ApiAttrKeyName = "__PowerHorseEngine_api_entry_key__"
local ApiKeyEntries = {}
local function HandleApiEntry(Item: Instance)
	assert(Item:GetAttribute(ApiAttrKeyName) == nil, `{Item} was already added to the api entry`)
	assert(
		typeof(Item) == "Instance" and Item:IsA("ModuleScript"),
		`Invalid API File. Expected ModuleScript, got {typeof(Item)} ({Item})`
	)
	local ItemData = require(Item)

	assert(
		typeof(ItemData) == "table",
		`Invalid API File. File did not return a table, got {typeof(ItemData)} ({ItemData})`
	)
	assert(
		typeof(ItemData.PowerHorseInit) == "function",
		`Expected function for PowerHorseInit for API file, got {typeof(ItemData.PowerHorseInit)} ({ItemData.PowerHorseInit})`
	)

	local EntryServant = PowerHorse.Servant.new()
	local UniqueApiKey, Api = GetUniqueApi(EntryServant)

	ApiKeyEntries[UniqueApiKey] = EntryServant
	Item:SetAttribute(ApiAttrKeyName, UniqueApiKey)
	ItemData.PowerHorseInit(Api)
end

local function HandleApiEntryRemoval(Item: Instance)
	local ApiKey = Item:GetAttribute(ApiAttrKeyName)
	if ApiKey == nil then
		return
	end
	if ApiKeyEntries[ApiKey] == nil then
		PowerHorse.warn(`{ApiKey} is not a valid PowerHorseEngine Client API Key`)
		return
	end
	Item:SetAttribute(ApiAttrKeyName, nil)
	ApiKeyEntries[ApiKey]:Destroy()
	ApiKeyEntries[ApiKey] = nil
end

CollectionService:GetInstanceAddedSignal(ExternalModuleApiTag):Connect(HandleApiEntry)
CollectionService:GetInstanceRemovedSignal(ExternalModuleApiTag):Connect(HandleApiEntryRemoval)

for _, entry in CollectionService:GetTagged(ExternalModuleApiTag) do
	task.spawn(function()
		HandleApiEntry(entry)
	end)
end

--> Initialize replication.
repeat
	task.wait(0.1)
	script.Parent = PHeClientRuntimeFolder
until script.Parent == PHeClientRuntimeFolder
ReplicatorScriptRemote:FireServer("initialize")

local ConsoleDebugger =
	LuaProvider.require(Constants.ProxyModule.Parent:WaitForChild("debug"):WaitForChild("console_debugger"))

ConsoleDebugger.ConsoleLogPowerHorseEngineRunning()
