-- Compiled with roblox-ts v2.3.0
local THREADER_DEBUG_LOGS_ENABLED = false
local SEND_DEBUG_LOG = function(Message, tickid)
	if not THREADER_DEBUG_LOGS_ENABLED then
		return nil
	end
	local uniqueID = if tickid ~= 0 and tickid == tickid and tickid then tostring(math.floor(tickid)) else nil
	print(`[THREADER][DEBUGGER]{if uniqueID ~= "" and uniqueID then ` [[{uniqueID}]] ` else ""}-{Message}`)
end
--[[
	*
	 * For controlling a thread outside of it's "scope".
	 *
	 * Use the custom `typeIs` function from `mekstuff-rbxts/core` to check if object is a threader.
	 * You should not use this as a stand alone library, You should install `mekstuff-rbxts/core` to access threader.
	 
]]
local threader
do
	threader = setmetatable({}, {
		__tostring = function()
			return "threader"
		end,
	})
	threader.__index = threader
	function threader.new(...)
		local self = setmetatable({}, threader)
		return self:constructor(...) or self
	end
	function threader:constructor(initiator, active, noAutoClose)
		if active == nil then
			active = false
		end
		self.initiator = initiator
		self.active = active
		self.noAutoClose = noAutoClose
		self._closed = false
		local tickID = tick()
		SEND_DEBUG_LOG(`constructing new threader thread`, tickID)
		local t = coroutine.create(function()
			SEND_DEBUG_LOG(`running threader coroutine`, tickID)
			local previousActiveState = not self.active
			local st
			local x = true
			while x do
				if self._closed == true then
					if st then
						SEND_DEBUG_LOG(`closing threader "st" coroutine as _closed is true and st: true`, tickID)
						coroutine.close(st)
					end
					SEND_DEBUG_LOG(`yielding threader current coroutine "t" as _closed is true. st is {st}`, tickID)
					coroutine.yield()
				end
				if self.active ~= previousActiveState then
					previousActiveState = self.active
					if self.active == true then
						SEND_DEBUG_LOG(`creating threader coroutine "st"`, tickID)
						st = coroutine.create(function()
							self.initiator(self)
							if not self.noAutoClose then
								self:tryClose()
							end
						end)
						SEND_DEBUG_LOG(`calling resume on threader coroutine "st"`, tickID)
						local success, args = coroutine.resume(st)
						assert(success, args)
					else
						if st ~= nil then
							SEND_DEBUG_LOG(`calling close on threader coroutine "st"`, tickID)
							coroutine.close(st)
						end
					end
				end
				task.wait()
			end
		end)
		SEND_DEBUG_LOG(`calling resume on threader coroutine "t"`, tickID)
		coroutine.resume(t)
	end
	function threader:isClosed()
		return self._closed
	end
	function threader:close()
		if self._closed == true then
			error("Threader already closed.")
		end
		self._closed = true
	end
	function threader:tryClose()
		if not self:isClosed() then
			self:close()
			return true
		end
		return false
	end
end
--[[
	*
	 * Checks if object is a threader
	 
]]
local function isThreader(object)
	local tickID = tick()
	SEND_DEBUG_LOG("isThreader query", tickID)
	local _object = object
	if type(_object) == "table" then
		local c = object
		local s, r = pcall(function()
			if c._closed ~= nil and c.tryClose ~= nil then
				SEND_DEBUG_LOG(`isThreader query results: true`, tickID)
				return true
			end
		end)
		if s == true and r == true then
			SEND_DEBUG_LOG(`isThreader query results: true`, tickID)
			return true
		else
			SEND_DEBUG_LOG(`isThreader query results: false`, tickID)
			return false
		end
	end
	SEND_DEBUG_LOG(`isThreader query results: false`, tickID)
	return false
end
local function setThreaderDebugLogsEnabled(State)
	local _state = State
	local _arg0 = type(_state) == "boolean"
	assert(_arg0, "State must be a boolean when `setThreaderDebugLogsEnabled`")
	local oldState = THREADER_DEBUG_LOGS_ENABLED
	if State then
		THREADER_DEBUG_LOGS_ENABLED = true
	end
	if oldState and not State then
		SEND_DEBUG_LOG("Debugger enabled")
	end
	if not oldState and State then
		SEND_DEBUG_LOG("Debugger disabled")
	end
	THREADER_DEBUG_LOGS_ENABLED = State
end
return {
	isThreader = isThreader,
	setThreaderDebugLogsEnabled = setThreaderDebugLogsEnabled,
	threader = threader,
}
