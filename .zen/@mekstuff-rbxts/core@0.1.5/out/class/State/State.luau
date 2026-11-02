-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local _typeIs = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "typeIs")._typeIs
local getCurrentRunningEffectObject = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "Effect", "Effect").getCurrentRunningEffectObject
local State
do
	local super = Pseudo
	State = setmetatable({}, {
		__tostring = function()
			return "State"
		end,
		__index = super,
	})
	State.__index = State
	function State.new(...)
		local self = setmetatable({}, State)
		return self:constructor(...) or self
	end
	function State:constructor(State)
		if State == nil then
			State = nil
		end
		super.constructor(self, "State")
		self.State = State
		self.internalSetStateCallback = nil
		self.Name = tostring(State)
	end
	function State:SetState(state)
		local stateValue
		local _state = state
		if type(_state) == "function" then
			stateValue = state(self.State)
		else
			stateValue = state
		end
		if self.internalSetStateCallback then
			self.internalSetStateCallback(stateValue, self.State)
		else
			self.State = stateValue
		end
		self.Name = tostring(self.State)
		return stateValue
	end
	function State:Use()
		return self:UseState(function(stateValue)
			return stateValue
		end)
	end
	function State:UseStateEffect(Callback)
		-- This used to use "usePropertyEffect"
		return self:Observe(function()
			if Callback then
				return Callback(self.State)
			end
		end, { "State" })
	end
	function State:UseState(Callback)
		local newState = State.new(self.State)
		local _upd = function()
			local cleanup
			local res = Callback(self.State)
			if _typeIs(res, "State") then
				res = res.State
			else
				local _res = res
				if type(_res) == "table" then
					local _res_1 = res
					local _condition = type(_res_1) == "table"
					if _condition then
						_condition = res[1]
					end
					if _condition ~= 0 and _condition == _condition and _condition ~= "" and _condition then
						cleanup = res[1]
						res = (res[0]).State
					end
				end
			end
			newState.State = res
			return cleanup
		end
		-- This used to use "useNextEffect"
		local _UseStateServant = self:ObserveNext(function()
			return _upd()
		end, { "State" })
		_upd()
		newState._dev.insert(_UseStateServant)
		self._dev.insert(newState)
		return newState
	end
	function State:__metamethod_call()
		local currentRunningEffectObject = getCurrentRunningEffectObject()
		if currentRunningEffectObject == nil then
			self:error(`Attempted to call() State outside of an Effect! To use State value outside an effect, use State.State property.`)
		end
		currentRunningEffectObject._inject_state(self)
		return self.State
	end
end
return {
	State = State,
}
