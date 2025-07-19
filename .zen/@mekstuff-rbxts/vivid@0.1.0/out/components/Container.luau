-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    18/05/2025 23:29:12
	
]]
local createEffect = TS.import(script, script.Parent.Parent, "create", "createEffect").createEffect
local _createElement = TS.import(script, script.Parent.Parent, "create", "createElement")
local createElement = _createElement.createElement
local withProps = _createElement.withProps
--[[
	*
	 * A `Frame` with `UIPadding` and `UIGridLayout` support.
	 
]]
local function Container(props)
	local Properties = withProps(props, true)
	Properties.UIPadding = nil
	Properties.CellPadding = nil
	Properties.CellSize = nil
	Properties.FillDirectionMaxCells = nil
	Properties.StartCorner = nil
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
	}), createElement("UIGridLayout", {
		CellPadding = props.CellPadding,
		CellSize = props.CellSize,
		FillDirectionMaxCells = props.FillDirectionMaxCells,
		StartCorner = props.StartCorner,
		FillDirection = props.FillDirection,
		HorizontalAlignment = props.HorizontalAlignment,
		VerticalAlignment = props.VerticalAlignment,
		SortOrder = props.SortOrder,
	}))
end
return {
	Container = Container,
}
