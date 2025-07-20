-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Pseudo = TS.import(script, script.Parent.Parent.Parent, "class", "Pseudo", "Pseudo").Pseudo
local Signal = TS.import(script, script.Parent.Parent.Parent, "class", "Signal", "Signal").Signal
local Queue = TS.import(script, script.Parent.Parent.Parent, "class", "Queue", "Queue").Queue
local BatchIterator
do
	local super = Pseudo
	BatchIterator = setmetatable({}, {
		__tostring = function()
			return "BatchIterator"
		end,
		__index = super,
	})
	BatchIterator.__index = BatchIterator
	function BatchIterator.new(...)
		local self = setmetatable({}, BatchIterator)
		return self:constructor(...) or self
	end
	function BatchIterator:constructor(Callback, Segments, BatchYieldTime, Sequential)
		if Segments == nil then
			Segments = 10
		end
		if BatchYieldTime == nil then
			BatchYieldTime = 0.1
		end
		if Sequential == nil then
			Sequential = false
		end
		super.constructor(self, "BatchIterator")
		self.Callback = Callback
		self.Segments = Segments
		self.BatchYieldTime = BatchYieldTime
		self.Sequential = Sequential
		self._segmentIndex = 0
		self._segnmentQueuePriority = 0
		self.Queue = Queue.new()
		self._dev.insert(self.Queue)
		self.Queue.AutoExecutions = true
	end
	function BatchIterator:AddEntryCore(SequentialState, ...)
		local args = { ... }
		if self._segmentIndex == self.Segments then
			self._segmentIndex = 1
			self._segnmentQueuePriority += 1
		else
			self._segmentIndex += 1
		end
		local addExec = function()
			self.Queue:Execute(function(CurrentPriority, PreviousPriority)
				-- let ExecSignal: Signal | undefined;
				if CurrentPriority ~= PreviousPriority and PreviousPriority ~= nil then
					task.wait(self.BatchYieldTime)
				end
				if SequentialState then
					self.Callback(unpack(args))
				else
					-- ExecSignal = new Signal();
					task.spawn(function()
						-- task.defer(() => {
						-- 	ExecSignal!.Fire();
						-- 	ExecSignal!.Destroy();
						-- });
						self.Callback(unpack(args))
					end)
				end
				-- return ExecSignal;
			end, self._segnmentQueuePriority)
		end
		addExec()
	end
	function BatchIterator:AddEntry(...)
		local args = { ... }
		return self:AddEntryCore(self.Sequential, unpack(args))
	end
	function BatchIterator:AddSequentialEntry(...)
		local args = { ... }
		return self:AddEntryCore(true, unpack(args))
	end
	function BatchIterator:AddParallelEntry(...)
		local args = { ... }
		return self:AddEntryCore(false, unpack(args))
	end
	function BatchIterator:AddSequentialEnd()
		return self.Queue:Execute(function()
			task.wait(self.BatchYieldTime)
		end, 999999)
	end
end
local function BatchIterateObject(Content, Callback, Segments, BatchYieldTime, Sequential)
	if Segments == nil then
		Segments = 10
	end
	if BatchYieldTime == nil then
		BatchYieldTime = 0.1
	end
	if Sequential == nil then
		Sequential = false
	end
	local iter = 0
	local completed = 0
	local _total = 0
	local CompletedSignal = Signal.new()
	local __didComplete = false
	local _registerComplete = function()
		if __didComplete then
			return nil
		end
		__didComplete = true
		CompletedSignal:Fire()
		CompletedSignal:Destroy()
	end
	for key, value in pairs(Content) do
		_total += 2
		local runCallback = function()
			Callback(key, value)
			completed += 1
			if completed == _total then
				_registerComplete()
			end
		end
		if not Sequential then
			task.spawn(function()
				runCallback()
			end)
		else
			runCallback()
		end
		iter += 1
		if iter == Segments then
			task.wait(BatchYieldTime)
			iter = 0
		end
	end
	_total = _total / 2
	if completed == _total then
		_registerComplete()
	end
	return CompletedSignal
end
local BatchIterate = setmetatable({
	new = function(...)
		local args = { ... }
		return BatchIterator.new(unpack(args))
	end,
}, {
	__call = function(_, ...)
		local args = { ... }
		local _args = args
		return BatchIterateObject(unpack(_args))
	end,
})
local default = BatchIterate
return {
	default = default,
	BatchIterate = BatchIterate,
	BatchIterator = BatchIterator,
	BatchIterateObject = BatchIterateObject,
}
