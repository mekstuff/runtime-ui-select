-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    30/04/2025 00:56:37
	
]]
local createEffect = TS.import(script, script.Parent.Parent, "create", "createEffect").createEffect
local _createElement = TS.import(script, script.Parent.Parent, "create", "createElement")
local createElement = _createElement.createElement
local withProps = _createElement.withProps
local createRef = TS.import(script, script.Parent.Parent, "create", "createRef").createRef
local createState = TS.import(script, script.Parent.Parent, "create", "createState").createState
local forEach = TS.import(script, script.Parent.Parent, "functions", "forEach").forEach
local onMount = TS.import(script, script.Parent.Parent, "lifecycles", "onMount").onMount
local use = TS.import(script, script.Parent.Parent, "use", "use").use
local function InfiniteScrollingFrame(props)
	local ScrollingFrameRef = createRef()
	local Properties = withProps(props, true)
	Properties.fetchItems = nil
	Properties.renderItem = nil
	Properties.uniqueIdExtractor = nil
	Properties.onScrollFetch = nil
	Properties.fetchTotal = nil
	Properties.initialFetchTotal = nil
	Properties.fetchId = nil
	local IsScrolledToBottom = false
	local ItemEntries, setItemEntries = createState({})
	local fetchItemsFunction = props.fetchItems
	local AddToItemEntries = function(Input)
		if #Input == 0 then
			return nil
		end
		setItemEntries(function(old)
			local _array = {}
			local _length = #_array
			local _oldLength = #old
			table.move(old, 1, _oldLength, _length + 1, _array)
			_length += _oldLength
			table.move(Input, 1, #Input, _length + 1, _array)
			return _array
		end)
	end
	onMount(function()
		local CheckIsScrolledToEnd = function()
			local IsAtEnd = ScrollingFrameRef().CanvasPosition.Y >= ScrollingFrameRef().AbsoluteCanvasSize.Y - ScrollingFrameRef().AbsoluteSize.Y - 5
			if IsAtEnd == false then
				IsScrolledToBottom = false
				return false
			end
			if IsScrolledToBottom == true then
				return true
			end
			IsScrolledToBottom = true
			if props.onScrollFetch ~= nil then
				-- defined manual on scroll fetch
				props.onScrollFetch(#use(function()
					return ItemEntries()
				end), function(...)
					local args = { ... }
					local results = fetchItemsFunction(unpack(args))
					AddToItemEntries(results)
					return results
				end)
			else
				-- default automatic on scroll fetch
				AddToItemEntries(fetchItemsFunction(#use(function()
					return ItemEntries()
				end), use(function()
					local _condition = props.fetchTotal
					if _condition == nil then
						_condition = 10
					end
					return _condition
				end)))
			end
			return true
		end
		createEffect(function(cleanup)
			local CanvasPositionListener = ScrollingFrameRef():GetPropertyChangedSignal("CanvasPosition"):Connect(CheckIsScrolledToEnd)
			cleanup(function()
				CanvasPositionListener:Disconnect()
			end)
		end)
	end)
	createEffect(function(effect)
		if props.fetchId == nil then
			return nil
		end
		effect.exit()
		setItemEntries({})
		AddToItemEntries(fetchItemsFunction(0, use(function()
			local _condition = props.initialFetchTotal
			if _condition == nil then
				_condition = props.fetchTotal
				if _condition == nil then
					_condition = 10
				end
			end
			return _condition
		end)))
	end)
	-- Initial fetches
	if use(function()
		return props.fetchId
	end) == nil then
		AddToItemEntries(fetchItemsFunction(0, use(function()
			local _condition = props.initialFetchTotal
			if _condition == nil then
				_condition = props.fetchTotal
				if _condition == nil then
					_condition = 10
				end
			end
			return _condition
		end)))
	end
	local _object = {
		ref = ScrollingFrameRef,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.XY,
	}
	for _k, _v in Properties do
		_object[_k] = _v
	end
	return createElement("ScrollingFrame", _object, forEach({
		each = ItemEntries(),
		children = function(eachprops, index, uid)
			return props.renderItem(eachprops, index, uid)
		end,
	})(), props.children)
end
return {
	InfiniteScrollingFrame = InfiniteScrollingFrame,
}
