-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local _typeIs = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "typeIs")._typeIs
local Queue
do
	local super = Pseudo
	Queue = setmetatable({}, {
		__tostring = function()
			return "Queue"
		end,
		__index = super,
	})
	Queue.__index = Queue
	function Queue.new(...)
		local self = setmetatable({}, Queue)
		return self:constructor(...) or self
	end
	function Queue:constructor()
		super.constructor(self, "Queue")
		self.Queue = {}
		self.Acsending = true
		self.QueueEmpty = true
		self.AutoExecutions = false
		self._autoExecuting = false
		self.PreviousPriority = nil
		self.CurrentPriority = nil
		self:CreateSignal("QueueEmptied")
		self:Observe(function()
			if self.AutoExecutions then
				self:_initAutoExecutions()
			end
		end, { "AutoExecutions" })
		self.Destroying:Connect(function()
			self:useAssignReadonlyProperty("Queue", nil)
			return nil
		end)
	end
	function Queue:_initAutoExecutions()
		if not self._autoExecuting and self.AutoExecutions then
			local runLoop
			runLoop = function()
				local cb = self:Dequeue()
				if cb == nil then
					self._autoExecuting = false
					return nil
				end
				if type(cb) == "function" then
					local res = cb()
					if _typeIs(res, "Pseudo") and res:IsA("Signal") then
						local c
						c = res:Connect(function()
							c:Disconnect()
							runLoop()
						end)
					else
						runLoop()
					end
				else
					self:warn(`Dequeued a non function from Queue due to AutoExecutions. and Execute() being called!`)
					runLoop()
				end
			end
			self._autoExecuting = true
			task.delay(nil, runLoop)
		end
	end
	function Queue:_isDestroyed()
		local _value = self._dev._destroyed
		return if _value ~= 0 and _value == _value and _value ~= "" and _value then true else false
	end
	function Queue:IsEmpty()
		return self.QueueEmpty
	end
	function Queue:Clear()
		table.clear(self.Queue)
	end
	function Queue:Execute(Callback, ...)
		local args = { ... }
		self:Enqueue((function()
			return Callback(self.CurrentPriority, self.PreviousPriority)
		end), unpack(args))
		self:_initAutoExecutions()
	end
	function Queue:Enqueue(Value, Priority)
		if self:_isDestroyed() then
			return nil
		end
		local _queue = self.Queue
		local _object = {
			value = Value,
		}
		local _left = "priority"
		local _condition = Priority
		if _condition == nil then
			_condition = 1
		end
		_object[_left] = _condition
		_object.t = tick()
		table.insert(_queue, _object)
		self.QueueEmpty = false
	end
	function Queue:Dequeue()
		if self:_isDestroyed() then
			return nil
		end
		table.sort(self.Queue, function(a, b)
			if a.priority == b.priority then
				return if self.Acsending then b.t > a.t else b.t < a.t
			else
				return if self.Acsending then b.priority > a.priority else b.priority < a.priority
			end
		end)
		local shifted = table.remove(self.Queue, 1)
		if shifted == nil then
			if self.QueueEmpty == false then
				self.QueueEmptied:Fire()
				self.QueueEmpty = true
			end
		else
			self:useAssignReadonlyProperty("PreviousPriority", self.CurrentPriority)
			self:useAssignReadonlyProperty("CurrentPriority", shifted.priority)
		end
		local _result = shifted
		if _result ~= nil then
			_result = _result.value
		end
		return _result
	end
end
local default = Queue
return {
	Queue = Queue,
	default = default,
}
