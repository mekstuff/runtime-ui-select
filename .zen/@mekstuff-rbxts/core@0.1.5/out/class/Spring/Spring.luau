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
				spr.updateTotalSprings(false)
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
		return self:setState(unpack(args))
	end
	function Spring:Disrupt(Goal, Damping, Frequency)
		if Damping == nil then
			Damping = self.Damping
		end
		if Frequency == nil then
			Frequency = self.Frequency
		end
		local _distruptionCompletedConnection
		_distruptionCompletedConnection = self.Completed:Connect(function()
			_distruptionCompletedConnection:Disconnect()
			spr.target(self, Damping, Frequency, {
				State = self._activeStateGoal,
			})
		end)
		spr.target(self, Damping, Frequency, {
			State = Goal,
		})
	end
	function Spring:ResetGoal(Goal)
		self._activeStateGoal = Goal
	end
end
return {
	Spring = Spring,
}
