-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local Players = game:GetService("Players")
local HitProcessors
HitProcessors = {
	PlayerCharacter = function(hit, targetPlayer)
		local _hit = hit
		if not (typeof(_hit) == "Instance") then
			return nil
		end
		local Character = hit.Parent
		if not Character then
			return nil
		end
		local PlayerOfCharacter = Players:GetPlayerFromCharacter(Character)
		if not PlayerOfCharacter then
			return nil
		end
		if targetPlayer then
			return if targetPlayer == PlayerOfCharacter then targetPlayer else nil
		end
		return PlayerOfCharacter
	end,
	MyCharacter = function(hit)
		return HitProcessors.PlayerCharacter(hit, Players.LocalPlayer)
	end,
}
local DebounceClass
do
	local super = Pseudo
	DebounceClass = setmetatable({}, {
		__tostring = function()
			return "DebounceClass"
		end,
		__index = super,
	})
	DebounceClass.__index = DebounceClass
	function DebounceClass.new(...)
		local self = setmetatable({}, DebounceClass)
		return self:constructor(...) or self
	end
	function DebounceClass:constructor()
		super.constructor(self, "Debouncer")
		self.HitProcessors = HitProcessors
	end
	function DebounceClass:Debounce(debouncer, callback, time, firstArgDebounce, connectParallel)
		local _debouncer = debouncer
		local _cb
		local _time
		local _firstArgDebounce = firstArgDebounce
		local _connectParallel = connectParallel
		local _debouncer_1 = debouncer
		if type(_debouncer_1) == "function" then
			_firstArgDebounce = _time
			_cb = debouncer
			_time = callback
		else
			local _debouncer_2 = debouncer
			if typeof(_debouncer_2) == "RBXScriptSignal" then
				_cb = callback
				_time = time
			else
				_debouncer = debouncer.debouncer
				_firstArgDebounce = debouncer.firstArgDebounce
				_cb = if debouncer.callback then debouncer.callback else (debouncer.debouncer)
				_time = debouncer.time
				_connectParallel = debouncer.connectParallel
			end
		end
		local _condition = _time
		if _condition == nil then
			_condition = 0.2
		end
		_time = _condition
		local _wrapper
		if _firstArgDebounce then
			local firstArgDebounces = {}
			_wrapper = function(...)
				local args = { ... }
				local firstArg = args[1]
				local _debouncer_2 = debouncer
				if type(_debouncer_2) == "table" then
					local dbt = debouncer
					if dbt.processFirstArg then
						firstArg = dbt.processFirstArg(firstArg)
					end
				end
				if firstArg == nil then
					return nil
				end
				local isDebounced = firstArgDebounces[firstArg]
				local _debouncer_3 = debouncer
				if type(_debouncer_3) == "table" then
					local dbt = debouncer
					if dbt.validator then
						local res = dbt.validator(isDebounced, unpack(args))
						self:assert(type(res) == "boolean", `expected boolean from your debounce validator, got {typeof(res)} "{res}"`)
						if res == true then
							isDebounced = false
						else
							return nil
						end
					end
				end
				if isDebounced then
					return nil
				end
				firstArgDebounces[firstArg] = true
				_cb(unpack(args))
				task.delay(_time, function()
					firstArgDebounces[firstArg] = nil
				end)
			end
		else
			local _lastCall = tick() - _time
			_wrapper = function(...)
				local args = { ... }
				local diff = tick() - _lastCall
				local isDebounced = diff < _time
				local _debouncer_2 = debouncer
				if type(_debouncer_2) == "table" then
					local dbt = debouncer
					if dbt.validator then
						local res = dbt.validator(isDebounced, unpack(args))
						self:assert(type(res) == "boolean", `expected boolean from your debounce validator, got {typeof(res)} "{res}"`)
						if res == true then
							isDebounced = false
						else
							return nil
						end
					end
				end
				if isDebounced then
					return nil
				end
				_lastCall = tick()
				return _cb(unpack(args))
			end
		end
		local __debouncer = _debouncer
		return if type(__debouncer) == "function" then _wrapper elseif _connectParallel then debouncer:ConnectParallel(_wrapper) else debouncer:Connect(_wrapper)
	end
end
local Debouncer = DebounceClass.new()
local default = Debouncer
return {
	DebounceClass = DebounceClass,
	Debouncer = Debouncer,
	default = default,
}
