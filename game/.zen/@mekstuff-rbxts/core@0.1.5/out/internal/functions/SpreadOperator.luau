-- Compiled with roblox-ts v3.0.0
local SpreadOperator = function(...)
	local t = { ... }
	local _object = {}
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(_t)
		local _object_1 = table.clone(_object)
		setmetatable(_object_1, nil)
		if _t then
			for _k, _v in _t do
				_object_1[_k] = _v
			end
		end
		_object = _object_1
	end
	for _k, _v in t do
		_callback(_v, _k - 1, t)
	end
	-- ▲ ReadonlyArray.forEach ▲
	return _object
end
local default = SpreadOperator
return {
	SpreadOperator = SpreadOperator,
	default = default,
}
