-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    18/05/2025 23:10:16
	
]]
local createEffect = TS.import(script, script.Parent.Parent, "create", "createEffect").createEffect
local _createElement = TS.import(script, script.Parent.Parent, "create", "createElement")
local createElement = _createElement.createElement
local withProps = _createElement.withProps
--[[
	*
	 * A `Frame` with `UIPadding` and `UIListLayout` support.
	 
]]
local function Box(props)
	local Properties = withProps(props, true)
	Properties.alignment = nil
	Properties.UIPadding = nil
	Properties.HorizontalFlex = nil
	Properties.ItemLineAlignment = nil
	Properties.Padding = nil
	Properties.VerticalFlex = nil
	Properties.Wraps = nil
	Properties.FillDirection = nil
	Properties.HorizontalAlignment = nil
	Properties.VerticalAlignment = nil
	Properties.SortOrder = nil
	local _object = table.clone(Properties)
	setmetatable(_object, nil)
	return createElement("Frame", _object, props.children, createElement("UIPadding", {
		PaddingLeft = createEffect(function()
			local _uIPadding = props.UIPadding
			local _result
			if type(_uIPadding) == "number" then
				_result = UDim.new(0, props.UIPadding)
			else
				local _uIPadding_1 = props.UIPadding
				local _result_1
				if typeof(_uIPadding_1) == "Vector2" then
					_result_1 = UDim.new(props.UIPadding.X)
				else
					local _uIPadding_2 = props.UIPadding
					local _result_2
					if typeof(_uIPadding_2) == "UDim" then
						_result_2 = props.UIPadding
					else
						local _result_3 = props.UIPadding
						if _result_3 ~= nil then
							_result_3 = _result_3[1]
						end
						_result_2 = _result_3
					end
					_result_1 = _result_2
				end
				_result = _result_1
			end
			local _condition = _result
			if _condition == nil then
				_condition = UDim.new()
			end
			return _condition
		end)(),
		PaddingTop = createEffect(function()
			local _uIPadding = props.UIPadding
			local _result
			if type(_uIPadding) == "number" then
				_result = UDim.new(0, props.UIPadding)
			else
				local _uIPadding_1 = props.UIPadding
				local _result_1
				if typeof(_uIPadding_1) == "Vector2" then
					_result_1 = UDim.new(props.UIPadding.Y)
				else
					local _uIPadding_2 = props.UIPadding
					local _result_2
					if typeof(_uIPadding_2) == "UDim" then
						_result_2 = props.UIPadding
					else
						local _result_3 = props.UIPadding
						if _result_3 ~= nil then
							_result_3 = _result_3[2]
						end
						_result_2 = _result_3
					end
					_result_1 = _result_2
				end
				_result = _result_1
			end
			local _condition = _result
			if _condition == nil then
				_condition = UDim.new()
			end
			return _condition
		end)(),
		PaddingRight = createEffect(function()
			local _uIPadding = props.UIPadding
			local _result
			if type(_uIPadding) == "number" then
				_result = UDim.new(0, props.UIPadding)
			else
				local _uIPadding_1 = props.UIPadding
				local _result_1
				if typeof(_uIPadding_1) == "Vector2" then
					_result_1 = UDim.new(props.UIPadding.X)
				else
					local _uIPadding_2 = props.UIPadding
					local _result_2
					if typeof(_uIPadding_2) == "UDim" then
						_result_2 = props.UIPadding
					else
						local _result_3 = props.UIPadding
						if _result_3 ~= nil then
							_result_3 = _result_3[3]
						end
						_result_2 = _result_3
					end
					_result_1 = _result_2
				end
				_result = _result_1
			end
			local _condition = _result
			if _condition == nil then
				_condition = UDim.new()
			end
			return _condition
		end)(),
		PaddingBottom = createEffect(function()
			local _uIPadding = props.UIPadding
			local _result
			if type(_uIPadding) == "number" then
				_result = UDim.new(0, props.UIPadding)
			else
				local _uIPadding_1 = props.UIPadding
				local _result_1
				if typeof(_uIPadding_1) == "Vector2" then
					_result_1 = UDim.new(props.UIPadding.Y)
				else
					local _uIPadding_2 = props.UIPadding
					local _result_2
					if typeof(_uIPadding_2) == "UDim" then
						_result_2 = props.UIPadding
					else
						local _result_3 = props.UIPadding
						if _result_3 ~= nil then
							_result_3 = _result_3[4]
						end
						_result_2 = _result_3
					end
					_result_1 = _result_2
				end
				_result = _result_1
			end
			local _condition = _result
			if _condition == nil then
				_condition = UDim.new()
			end
			return _condition
		end)(),
	}), createElement("UIListLayout", {
		HorizontalFlex = props.HorizontalFlex,
		ItemLineAlignment = props.ItemLineAlignment,
		Padding = props.Padding,
		VerticalFlex = props.VerticalFlex,
		Wraps = props.Wraps,
		FillDirection = props.FillDirection,
		SortOrder = props.SortOrder,
		HorizontalAlignment = createEffect(function()
			if props.alignment ~= nil then
				if props.alignment == Enum.HorizontalAlignment.Center or props.alignment == Enum.VerticalAlignment.Center then
					return Enum.HorizontalAlignment.Center
				end
				if props.alignment == Enum.HorizontalAlignment.Left then
					return Enum.HorizontalAlignment.Left
				end
				if props.alignment == Enum.HorizontalAlignment.Right then
					return Enum.HorizontalAlignment.Right
				end
			end
			if props.HorizontalAlignment ~= nil then
				return props.HorizontalAlignment
			end
			return Enum.HorizontalAlignment.Left
		end)(),
		VerticalAlignment = createEffect(function()
			if props.alignment ~= nil then
				if props.alignment == Enum.VerticalAlignment.Center or props.alignment == Enum.HorizontalAlignment.Center then
					return Enum.VerticalAlignment.Center
				end
				if props.alignment == Enum.VerticalAlignment.Top then
					return Enum.VerticalAlignment.Top
				end
				if props.alignment == Enum.VerticalAlignment.Bottom then
					return Enum.VerticalAlignment.Bottom
				end
			end
			if props.VerticalAlignment ~= nil then
				return props.VerticalAlignment
			end
			return Enum.VerticalAlignment.Top
		end)(),
	}))
end
return {
	Box = Box,
}
