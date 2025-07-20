-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local GetIsValidDefineFunctionName = TS.import(script, script.Parent.Parent, "functions", "GetIsValidDefineFunctionName").GetIsValidDefineFunctionName
--[[
	*
	 * A `ClientReplicator` is a `Replicator` for the client, it is used to communicate to the server.
	 *
	 * It directly adds the .Replicator to the `object` provided if .Replicator isn't already provided.
	 
]]
local function CreateClientReplicator(object)
	return {
		Define = function(_, __, ...)
			local args = { ... }
			local funcName = (debug.info(2, "n"))
			if funcName == "Define" then
				--  in cases where funcName is "Define", it's where the replicator has not been replicated fully yet and
				--  the Definition was called by an external source waiting for the Replicator to complete. See Pseudo.ts [_thisTempReplicator]
				funcName = (debug.info(3, "n"))
			end
			object.assert(object, GetIsValidDefineFunctionName(funcName), `Invalid Function binded to Replicator.Define function. Expected lowercase as first letter and "Serer" as last word. got "\{funcName\}".\ne.g. "runFunctionServer"`)
			if funcName == nil then
				object.error(object, "Cannot Define Replicator method as the function seems to be anonymous and/or has no assigned debug name.")
			end
			local ___pseudoreplicator_queryServerCall = object._dev.___pseudoreplicator_queryServerCall
			-- yield until it exists if it doesn't.
			if ___pseudoreplicator_queryServerCall == nil then
				local TRIES = 0
				while true do
					___pseudoreplicator_queryServerCall = object._dev.___pseudoreplicator_queryServerCall
					if ___pseudoreplicator_queryServerCall ~= nil then
						break
					end
					if TRIES == 10 then
						object.warn(object, `Possible Replication Error, Awaiting internal _dev function ___pseudoreplicator_queryServerCall to be exposed, No update received.\nMake sure the Pseudo to be replicated was used on the server initially.`)
					end
					task.wait(TRIES / 10)
					TRIES += 1
				end
			end
			return ___pseudoreplicator_queryServerCall(funcName, unpack(args))
		end,
		Transmit = function(_, __, func, ...)
			local args = { ... }
			return func(unpack(args))
		end,
		WithDebounce = function(_, cb)
			return cb
		end,
	}
end
return {
	CreateClientReplicator = CreateClientReplicator,
}
