-- Compiled with roblox-ts v3.0.0
local useAlpha = function(inputColor, alpha)
	local h, s, v = inputColor:ToHSV()
	return Color3.fromHSV(h, s, math.clamp(v + (math.abs(alpha) - 1), 0, 1))
end
local color3
color3 = {
	new = function(r, g, b, alpha)
		if alpha == nil then
			alpha = 1
		end
		local _r = r
		if typeof(_r) == "Color3" then
			local _condition = g
			if _condition == nil then
				_condition = 1
			end
			local _alpha = _condition
			return color3.new(r.R, r.G, r.B, _alpha)
		end
		local c = Color3.new(r, g, b)
		if alpha ~= 0 and alpha == alpha and alpha then
			return useAlpha(c, alpha)
		end
		return c
	end,
	fromRGB = function(r, g, b, alpha)
		if alpha == nil then
			alpha = 1
		end
		local c = Color3.fromRGB(r, g, b)
		if alpha ~= 0 and alpha == alpha and alpha then
			return useAlpha(c, alpha)
		end
		return c
	end,
	fromHSV = function(h, s, v, alpha)
		if alpha == nil then
			alpha = 1
		end
		local c = Color3.fromHSV(h, s, v)
		if alpha ~= 0 and alpha == alpha and alpha then
			return useAlpha(c, alpha)
		end
		return c
	end,
	adjustHSV = function(inputColor, saturation, value)
		local h, s, v = inputColor:ToHSV()
		local _condition = saturation
		if _condition == nil then
			_condition = 0
		end
		local _exp = math.clamp(s + _condition, 0, 1)
		local _condition_1 = value
		if _condition_1 == nil then
			_condition_1 = 0
		end
		return Color3.fromHSV(h, _exp, math.clamp(v + _condition_1, 0, 1))
	end,
}
return color3
