-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    30/01/2025 09:53:19
	
	    Adapter for using ui-labs stories with vivid.
	
]]
local Box = TS.import(script, script.Parent.Parent, "components", "Box").Box
local createScope = TS.import(script, script.Parent.Parent, "create", "createScope").createScope
local createState = TS.import(script, script.Parent.Parent, "create", "createState").createState
local createElement = TS.import(script, script.Parent.Parent, "create", "createElement").createElement
local function UILabsStoryAdapter(controls, render, config)
	-- Loading UI Labs only when the adapter is being used (peer dependency, doesn't mean it is always available.)
	local UILabsLazyLoad = TS.Promise.new(function(resolve)
		resolve(TS.import(script, TS.getModule(script, "@rbxts", "ui-labs").src))
	end):expect()
	local UpdateControlStates = UILabsLazyLoad.UpdateControlStates
	local CreateControlStates = UILabsLazyLoad.CreateControlStates
	return {
		controls = controls,
		render = function(uilabsprops)
			local StoryScope = createScope()
			local states = CreateControlStates(uilabsprops.converted, controls, function(_default)
				local value, setter = createState(_default)
				return {
					value = value,
					setter = setter,
				}
				-- eslint-disable-next-line
			end)
			local cleanupFunction
			local _object = {
				setCleanupFunction = function(callback)
					local _arg0 = cleanupFunction == nil
					assert(_arg0, "cleanup function already defined.")
					cleanupFunction = callback
				end,
			}
			for _k, _v in uilabsprops do
				_object[_k] = _v
			end
			local props_to_pass = _object
			for key, value in pairs(states) do
				props_to_pass[key] = value.value()
			end
			uilabsprops.subscribe(function(values)
				UpdateControlStates(states, uilabsprops.converted, values, function(state, value)
					state.setter(value)
				end)
			end)
			StoryScope.Close()
			local WrappedBox = nil
			local _result = config
			if _result ~= nil then
				_result = _result.wrapInBox
			end
			if _result == true then
				WrappedBox = createElement(Box, {
					alignment = Enum.HorizontalAlignment.Center,
					Size = UDim2.fromScale(0.95, 0.95),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					BackgroundTransparency = 0.95,
					Parent = uilabsprops.target,
				})
			end
			local Element = createElement(function()
				return render(props_to_pass, nil)
			end)
			Element.Parent = WrappedBox or uilabsprops.target
			return function()
				if cleanupFunction ~= nil then
					local s, r = pcall(function()
						cleanupFunction()
					end)
					if s == false then
						warn(r)
					end
				end
				Element:Destroy()
				StoryScope.Destroy()
				local _result_1 = WrappedBox
				if _result_1 ~= nil then
					_result_1:Destroy()
				end
			end
		end,
	}
end
return {
	UILabsStoryAdapter = UILabsStoryAdapter,
}
