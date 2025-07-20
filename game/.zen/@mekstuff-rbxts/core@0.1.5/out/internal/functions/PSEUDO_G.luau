-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local warnp = TS.import(script, script.Parent.Parent, "debug", "warn").warnp
local PSEUDO_G
PSEUDO_G = {
	set = function(key, value)
		PSEUDO_G[key] = value
	end,
	get = function(key, timeout)
		return TS.Promise.new(function(resolve, reject)
			local _value = PSEUDO_G[key]
			if _value ~= 0 and _value == _value and _value ~= "" and _value then
				return resolve(PSEUDO_G[key])
			end
			if timeout == 0 then
				return resolve(nil)
			end
			local t = 0
			local w = 0.5
			local err = `Infinite possible yield for "get" of Pseudo._G on "{key}".`
			while true do
				local _value_1 = PSEUDO_G[key]
				if _value_1 ~= 0 and _value_1 == _value_1 and _value_1 ~= "" and _value_1 then
					resolve(PSEUDO_G[key])
					return nil
				end
				if t == 8 and not (timeout ~= 0 and timeout == timeout and timeout) then
					warnp(err)
				end
				local _exp = t
				local _condition = timeout
				if not (_condition ~= 0 and _condition == _condition and _condition) then
					_condition = 120
				end
				if _exp == _condition then
					if timeout ~= 0 and timeout == timeout and timeout then
						return resolve(nil)
					end
					reject(err)
					return nil
				end
				t += w
				task.wait(w)
			end
		end)
	end,
}
return {
	PSEUDO_G = PSEUDO_G,
}
