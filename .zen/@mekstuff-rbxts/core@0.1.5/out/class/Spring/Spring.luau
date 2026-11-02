-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local State = TS.import(script, script.Parent.Parent, "State", "State").State
local spr = require(script.Parent:WaitForChild("spr"))
local Spring
do
	local super = State
	Spring = setmetatable({}, {
		__tostring = function()
			return "Spring"
		end,
		__index = super,
	})
	Spring.__index = Spring
	function Spring.new(...)
		local self = setmetatable({}, Spring)
		return self:constructor(...) or self
	end
	function Spring:constructor(DefaultValue, Damping, Frequency)
		if Damping == nil then
			Damping = 0.2
		end
		if Frequency == nil then
			Frequency = 3
		end
		super.constructor(self, DefaultValue)
		self.Damping = Damping
		self.Frequency = Frequency
		self:CreateSignal("Completed")
		self:Observe(function()
			spr.updateTotalSprings(true)
			return function()
				spr.updateTotalSprings(false, self)
			end
		end, {})
		self._activeStateGoal = DefaultValue
		self.internalSetStateCallback = function(query)
			self._activeStateGoal = query
			spr.target(self, self.Damping, self.Frequency, {
				State = query,
			})
		end
		self:ObserveNext(function()
			if self._activeStateGoal == nil then
				return nil
			end
			spr.target(self, self.Damping, self.Frequency, {
				State = self._activeStateGoal,
			})
		end, { "Damping", "Frequency" })
	end
	function Spring:SetGoal(...)
		local args = { ... }
		spr.completed(self, function(...)
			local completedArgs = { ... }
			self.Completed:Fire(unpack(completedArgs))
		end)
		return self:SetState(unpack(args))
	end
	function Spring:Disrupt(Goal, props)
		local DisruptionStateGoal = function()
			local _exp = self
			local _result = props
			if _result ~= nil then
				_result = _result.Damping
			end
			local _condition = _result
			if _condition == nil then
				_condition = self.Damping
			end
			local _result_1 = props
			if _result_1 ~= nil then
				_result_1 = _result_1.Frequency
			end
			local _condition_1 = _result_1
			if _condition_1 == nil then
				_condition_1 = self.Frequency
			end
			spr.target(_exp, _condition, _condition_1, {
				State = Goal,
			})
		end
		local resetToActiveStateGoal = function()
			local _exp = self
			local _result = props
			if _result ~= nil then
				_result = _result.Damping
			end
			local _condition = _result
			if _condition == nil then
				_condition = self.Damping
			end
			local _result_1 = props
			if _result_1 ~= nil then
				_result_1 = _result_1.Frequency
			end
			local _condition_1 = _result_1
			if _condition_1 == nil then
				_condition_1 = self.Frequency
			end
			spr.target(_exp, _condition, _condition_1, {
				State = self._activeStateGoal,
			})
		end
		local _result = props
		if _result ~= nil then
			_result = _result.Lifetime
		end
		if not (_result ~= 0 and _result == _result and _result) then
			spr.completed(self, function()
				resetToActiveStateGoal()
			end)
			DisruptionStateGoal()
		else
			DisruptionStateGoal()
			task.delay(props.Lifetime, function()
				resetToActiveStateGoal()
			end)
		end
	end
	function Spring:ResetGoal(Goal)
		self._activeStateGoal = Goal
	end
end
return {
	Spring = Spring,
}
