-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    06/06/2025 21:39:57
	
]]
--[[
	*
	 * extends props, used for cases where props.props exists for passing properties to other components.
	 *
	 * e.g.
	 
]]
local function extp(def, ...)
	local args = { ... }
	local c
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(t)
		local _t = t
		local _exp = type(_t) == "table"
		local _t_1 = t
		local _arg1 = `[extp] Attempted to extend props from non table object: {typeof(_t_1)}`
		assert(_exp, _arg1)
		local _object = {}
		if c ~= 0 and c == c and c ~= "" and c then
			for _k, _v in c do
				_object[_k] = _v
			end
		end
		if t then
			for _k, _v in t do
				_object[_k] = _v
			end
		end
		c = _object
	end
	for _k, _v in args do
		_callback(_v, _k - 1, args)
	end
	-- ▲ ReadonlyArray.forEach ▲
	local _object = {}
	if def ~= 0 and def == def and def ~= "" and def then
		for _k, _v in def do
			_object[_k] = _v
		end
	end
	c = _object
	return c
end
return {
	extp = extp,
}
