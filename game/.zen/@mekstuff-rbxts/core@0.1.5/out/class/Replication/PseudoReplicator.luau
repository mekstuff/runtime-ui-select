-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local ___ = TS.import(script, script.Parent.Parent.Parent)
local Debouncer = ___.Debouncer
local Pseudo = ___.Pseudo
local GetIsValidTransmitterFunctionName = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "GetIsValidTransmitterFunctionName").GetIsValidTransmitterFunctionName
local ReplicatorTransmitterRemote = TS.import(script, script.Parent.Parent.Parent, "internal", "Replicator").ReplicatorTransmitterRemote
local IsServer = game:GetService("RunService"):IsServer()
local HttpService = game:GetService("HttpService")
local LiveTransmitters = {}
--[[
	*
	 * A class that is created whenever EnabledReplication is called on a Pseudo object. The PseudoReplicator of that class can be accessed using
	 * `Pseudo.Replicator`. (Note that it only exists after `EnableReplication` is called and is available on both the server and the client.)
	 
]]
local PseudoReplicator
do
	local super = Pseudo
	PseudoReplicator = setmetatable({}, {
		__tostring = function()
			return "PseudoReplicator"
		end,
		__index = super,
	})
	PseudoReplicator.__index = PseudoReplicator
	function PseudoReplicator.new(...)
		local self = setmetatable({}, PseudoReplicator)
		return self:constructor(...) or self
	end
	function PseudoReplicator:constructor(_PseudoOrigin)
		super.constructor(self, "PseudoReplicator")
		self._PseudoOrigin = _PseudoOrigin
		self:assert(IsServer, "A Server Sided PseudoReplicator cannot be created on the Client.")
	end
	function PseudoReplicator:WithDebounce(Callback, Time, FirstArgumentIsDebounced)
		if FirstArgumentIsDebounced == nil then
			FirstArgumentIsDebounced = true
		end
		return Debouncer:Debounce(Callback, Time, true)
	end
	function PseudoReplicator:Define(Callback, ...)
		local args = { ... }
		local _CB = Callback
		if IsServer == true and Callback ~= nil then
			return TS.Promise.new(function(resolve)
				return resolve(_CB(unpack(args)))
			end):catch(function(err)
				error(err)
			end)
		end
		return if Callback then (_CB(unpack(args))) else nil
	end
	function PseudoReplicator:TransmitMessage(Client, Callback, ...)
		local args = { ... }
		local RootTransmissionFunctionName = (debug.info(2, "n"))
		if not (type(RootTransmissionFunctionName) == "string") then
			self:error(`Cannot "Transmit" Replicator method as the function seems to be anonymous and/or has no debug name.`)
		end
		self:assert(GetIsValidTransmitterFunctionName(RootTransmissionFunctionName), `Invalid Function binded to TransmitMessage function. Expected lowercase as first letter and "Client" as last word. got "{RootTransmissionFunctionName}".\ne.g. "runFunctionClient"`)
		local _client = Client
		local TargetClient = if typeof(_client) == "Instance" then Client else Client.Player
		if TargetClient == nil then
			local _client_1 = Client
			ReplicatorTransmitterRemote:FireClient(if typeof(_client_1) == "Instance" then Client else Client.Player, RootTransmissionFunctionName, self:GetIdAsync(), self._PseudoOrigin:GetIdAsync(), nil, unpack(args))
		else
			ReplicatorTransmitterRemote:FireAllClients(RootTransmissionFunctionName, self:GetIdAsync(), self._PseudoOrigin:GetIdAsync(), nil, unpack(args))
		end
	end
	function PseudoReplicator:Transmit(Client, Callback, ...)
		local args = { ... }
		local RootTransmissionFunctionName = (debug.info(2, "n"))
		if not (type(RootTransmissionFunctionName) == "string") then
			self:error(`Cannot "Transmit" Replicator method as the function seems to be anonymous and/or has no debug name.`)
		end
		self:assert(GetIsValidTransmitterFunctionName(RootTransmissionFunctionName), `Invalid Function binded to Replicator.Transmit function. Expected lowercase as first letter and "Client" as last word. got "{RootTransmissionFunctionName}".\ne.g. "runFunctionClient"`)
		local RootTransmissionFunction = (debug.info(2, "f"))
		-- The new callback for this function "RootTransmissionFunctionName" will now be changed
		-- meaining future calls will use this new function
		-- so the transmitter is never recreated, since a new function will be called, no longer whatever "RootTransmissionFunctionName" is
		local PseudoOriginNextObjectProxy = self._PseudoOrigin._dev.OBJECT_PROXY
		local newFunctionCallback = function(_, ...)
			local args = { ... }
			return TS.Promise.new(function(resolve, _, onCancel)
				local _client = Client
				local _condition = typeof(_client) == "Instance"
				if not _condition then
					_condition = Client.TransmitterId == nil
				end
				local TransmitterId = if _condition then HttpService:GenerateGUID() .. self:GetIdAsync() else Client.TransmitterId
				if LiveTransmitters[TransmitterId] then
					-- Cannot have the same transmitter id live, drop the new request (this one).
					-- return resolve(1 as never);
					return resolve(nil)
				end
				local _client_1 = Client
				local _condition_1 = typeof(_client_1) == "Instance"
				if not _condition_1 then
					_condition_1 = Client.TransmitterTimeout == nil
				end
				local DelayTimeoutThread = task.delay(if _condition_1 then 120 else Client.TransmitterTimeout, function()
					-- automatically drop after x seconds
					resolve(nil)
					LiveTransmitters[TransmitterId] = nil
				end)
				LiveTransmitters[TransmitterId] = {
					resolver = resolve,
					thread = DelayTimeoutThread,
				}
				onCancel(function()
					if not LiveTransmitters[TransmitterId] or LiveTransmitters[TransmitterId].thread ~= DelayTimeoutThread then
						return nil
					end
					task.cancel(DelayTimeoutThread)
					LiveTransmitters[TransmitterId] = nil
				end)
				local _client_2 = Client
				ReplicatorTransmitterRemote:FireClient(if typeof(_client_2) == "Instance" then Client else Client.Player, RootTransmissionFunctionName, self:GetIdAsync(), self._PseudoOrigin:GetIdAsync(), TransmitterId, unpack(args))
			end):catch(function(err)
				error(err)
			end)
		end
		local ExposedInitialCallArguments = _G[`Pseudo.ValidReplicatorFuncNameData.{tostring(RootTransmissionFunction)}`]
		self:assert(ExposedInitialCallArguments, `You function did not expose any arguments globally. Replicator failed to run.`)
		-- Override the root function so any prior calls to this function will go through the Replicator. (it will no longer need to use _G.)
		PseudoOriginNextObjectProxy[RootTransmissionFunctionName] = function(_this, _player, ...)
			local arg0 = { ... }
			newFunctionCallback(self, unpack(arg0))
		end
		-- Run the function initially with the correct arguments
		return newFunctionCallback(self, unpack({ select(3, unpack(ExposedInitialCallArguments)) }))
	end
	function PseudoReplicator:ResolveTransmitter(TransmitterId, Successful, ...)
		local data = { ... }
		local IsALiveTransmitter = LiveTransmitters[TransmitterId]
		if IsALiveTransmitter == nil then
			return nil
		end
		task.cancel(IsALiveTransmitter.thread)
		if Successful then
			IsALiveTransmitter.resolver(unpack(data))
		else
			IsALiveTransmitter.resolver(nil)
		end
		LiveTransmitters[TransmitterId] = nil
	end
end
return {
	PseudoReplicator = PseudoReplicator,
}
